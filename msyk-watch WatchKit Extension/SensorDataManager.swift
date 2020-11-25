//
//  CoreMotion.swift
//  msyk-watch WatchKit Extension
//
//  Created by 水谷昌幸 on 2020/11/16.
//

import Foundation
import UIKit
import CoreMotion
import WatchConnectivity
import WatchKit


class MotionSensor: NSObject,ObservableObject
{
    let motionManager = CMMotionManager()
    //デバイスがモーションデータに対応しているかどうか
    
    private(set) var isRecording = false
    private let headerText = "timestamp,attitudeX,attitudeY,attitudeZ,gyroX,gyroY,gyroZ,gravityX,gravityY,gravityZ,accX,accY,accZ"
    private var recordText = ""
    var format = DateFormatter()
     
    @Published var isStarted = false
    @Published var xStr = "0.0"
    @Published var yStr = "0.0"
    @Published var zStr = "0.0"
    //xの加速度がはいる配列
    @Published var x:String = ""
    //@Published var x : [String] = []
    @Published var y: [String] = []
    @Published var z : [String] = []
    @Published var tempx:String = "XXX"
    //@Published var fileName = "x"
    
    //データ更新間隔を指定
    //データ取得の開始と、データ更新時に呼び出される関数を指定
    func start(){
        
        //デバッグ用
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("paths:",paths)
        let filePath = NSHomeDirectory() + "/Documents/"
        print("filepath:",filePath)
        
        
        
        //recordText = ""
        //recordText += headerText + "\n"
        if motionManager.isDeviceMotionAvailable{
            motionManager.deviceMotionUpdateInterval = 1    //インターバル決定
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            print("paths:",paths)
            let filePath = NSHomeDirectory() + "/Documents/"
            print("filepath:",filePath)
            let docsDirect = paths[0] //音声用???
            let fileURL = docsDirect.appendingPathComponent(sensorDataFileName)
            
            //let fileURL =
            //let fileURL = URL(fileURLWithPath: path)
            //print("fileURL",fileURL)
            //let fileURL = self.fileURL(filePath: <#T##String#>)

            let stringfirstline = "Timestamp,Pitch,Roll,Yaw,RotionX,RotionY,RotationZ,GravityX,GravityY,GravityZ,AxelX,AxelY,AxelZ\n"
            self.creatDataFile(onetimestring: stringfirstline, fileurl: fileURL)
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
                //self.getdeviceMotion(deviceMotion: motion!)
                //self.getMotionDataAcc(motionData: motion!)
                self.saveMotionData(deviceMotion: motion!, fileurl: fileURL)
                self.updateMotionData(deviceMotion: motion!)
            })
        print("Started sensor updates")
    }else{
        print("Failed to start sensor updates")
        }
        isStarted = true
        //isStartedをフラグとして使い、「start()」時にtrue、「stop()」時にfalse
    }
    
    
    func stop()
    {
        if motionManager.isDeviceMotionAvailable{
        isStarted = false
        motionManager.stopDeviceMotionUpdates()
        print("isStarted:",isStarted)
        print("Stopped sensor updates")
        //配列をcsvにして保存する関数を呼び出す
        //self.saveSensorDataToCsv(fileName: tempx)
       // self.connector.send()
        }else {
            print("Failed stopping sensor updates")
        }
    }
    
    
    //更新のたびにx, y, z方向への加速度を、xStr, yStr, zStrに文字列として格納
    func updateMotionData(deviceMotion:CMDeviceMotion)
    {
        xStr = String(deviceMotion.userAcceleration.x)
        yStr = String(deviceMotion.userAcceleration.y)
        zStr = String(deviceMotion.userAcceleration.z)
    //配列x,y,zに加速度を格納
        x.append(xStr)
        y.append(yStr)
        z.append(zStr)
    //配列をcsvにして保存したい
    }
    
    func addRecordText(addText:String)
    {
        recordText += addText + "\n"
    }
    
    /*
    @IBAction func button(){
        saveSensorDataToCsv(fileName: fileName)
       }
    */
    
    
    
    func getdeviceMotion(deviceMotion: CMDeviceMotion){
        print("userAccelation")
        print("accX:", deviceMotion.userAcceleration.x)
        print("accY:", deviceMotion.userAcceleration.y)
        print("accZ:", deviceMotion.userAcceleration.z)
        print("rotationRate")
        print("gyroX:", deviceMotion.rotationRate.x)
        print("gyroY:", deviceMotion.rotationRate.y)
        print("gyroZ:", deviceMotion.rotationRate.z)
        print("attitude")
        print("attitudeX:", deviceMotion.attitude.pitch)
        print("attitudeY:", deviceMotion.attitude.roll)
        print("attitudeZ:", deviceMotion.attitude.yaw)
        print("gravity")
        print("gravityX:", deviceMotion.gravity.x)
        print("gravityY:", deviceMotion.gravity.y)
        print("gravityZ:", deviceMotion.gravity.z)
        print("magneticField?")
        print("magneticFieldX:", deviceMotion.magneticField.field.x)
        print("magneticFieldY:", deviceMotion.magneticField.field.y)
        print("magneticFieldZ:", deviceMotion.magneticField.field.z)
    }
    
    func getMotionDataAcc(motionData:CMAccelerometerData){
        print("生データ")
        print("motionData.accX:", motionData.acceleration.x)
        print("motionData.accY:", motionData.acceleration.y)
        print("motionData.accZ:", motionData.acceleration.z)
    }
     /*
        xStr = String(motionData.rotationRate.x)
        yStr = String(motionData.rotationRate.y)
        zStr = String(motionData.rotationRate.z)
    }
    */
    
    func saveMotionData(deviceMotion: CMDeviceMotion, fileurl: URL){
        //let fileURL = URL
        let string = "\(deviceMotion.timestamp),\(deviceMotion.attitude.pitch),\(deviceMotion.attitude.roll),\(deviceMotion.attitude.yaw),\(deviceMotion.rotationRate.x),\(deviceMotion.rotationRate.y),\(deviceMotion.rotationRate.z),\(deviceMotion.gravity.x),\(deviceMotion.gravity.y),\(deviceMotion.gravity.z),\(deviceMotion.userAcceleration.x),\(deviceMotion.userAcceleration.y),\(deviceMotion.userAcceleration.z)\n"
        self.appendDataToFile(string: string, fileurl: fileurl)
        print("success to saveMotionData")
        print(string)
        print("fileurl:", fileurl)
    }
    
    func appendDataToFile(string: String, fileurl: URL){
        if let outputStream = OutputStream(url: fileurl, append: true) {
            outputStream.open()
            let data = string.data(using: .utf8)!
            let bytesWritten = outputStream.write(string, maxLength: data.count)
            if bytesWritten < 0 { print("Data write(append) failed.") }
            outputStream.close()
        } else {
            print("Unable to open file for appending data.")
        }
    }

    func creatDataFile(onetimestring: String, fileurl: URL){
        if FileManager.default.fileExists(atPath: fileurl.path) {
          do {
            try FileManager.default.removeItem(atPath: fileurl.path)
          } catch {
              print("Existing sensor data file cannot be deleted.")
          }
        }
        let data = onetimestring.data(using: .utf8)
        if FileManager.default.createFile(atPath: fileurl.path, contents: data, attributes: nil){
            print("Data file was created successfully.")
        } else {
            print("Failed creating data file.")
        }
    }
    
    
    func testDataFileSave()->String{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let fileURL = docsDirect.appendingPathComponent(sensorDataFileName)
        creatDataFile(onetimestring: "First line\n", fileurl: fileURL)
        appendDataToFile(string: "Second line\n", fileurl: fileURL)
        print("Saved test data file")
        return "Saved test data file"
    }
    
    
    
    //func fileURL(withPath path: String) -> URL{}
    
    
    func saveSensorDataToCsv(fileName:String)
    {
        
        let filePath = NSHomeDirectory() + "/Documents/" + fileName + ".csv"
        print(NSHomeDirectory())
        //print(WCSession.default.isReachable)
        
        do{
    
            //try fruitsArray.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
            try x.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
            //recordText
            //x
            print("Success to Write CSV")
        }catch let error as NSError{
            print("Failure to Write CSV\n\(error)")
        }
    }
    
    
    
    //ファイル読み取り
    func searchAllFiles() -> [String]{
            var paths = [String]()
            do{
            paths = try FileManager().contentsOfDirectory(atPath: NSHomeDirectory() + "/Documents")
            print(paths)
            }catch let error as NSError{
                print(error)
            }
            return paths
        }
}
            //, fileArrData : [[String]]
            
            //let filePath = NSHomeDirectory() + "/Documents/" + fileName + ".csv"
            //print(filePath)
            //var fileStrData:String = ""
            /*
            //StringのCSV用データを準備
            for singleArray in fileArrData
            {
                for singleString in singleArray
                {
                    x += "\"" + singleString + "\""
                    if singleString != singleArray[singleArray.count-1]
                    {
                            x += ","
                        
                    }
                    
                }
                x += "\n"
                
            }
            print(x)
            */
/*
            do{
                    try x.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
                    print("Success to Wite the File")
                
            }
            catch let error as NSError{
                    print("Failure to Write File\n\(error)")
                
            }
            
        }
        
    }
*/
    
  //ファイル送信
/*
        override init()
        {
            super.init()
            //受け取るための準備、WCSessionをアクティベート
            if WCSession.isSupported()
            {
                 WCSession.default.delegate = self
                WCSession.default.activate()

            }
        }

    func send()
    {
    if WCSession.default.isReachable
    {
        WCSession.default.transferFile( NSHomeDirectory() + "/Documents/" + fileName + ".csv",x)
     }
     }
 */
    
    
    
    
//->WCSessionFileTransfer)
 
        
        
        /*
        WCSession.default.transferFile( NSHomeDirectory() + "/Documents/" + fileName + ".csv",filePath: [String : Any]?)->WCSessionFileTransfer
 */
        /*{ error in
            print(error)
        }
 */
    










         /*
            var fileStrData:String = ""
            //StringのCSV用データを準備
            for singleArray in fileArrData
            {
                for singleString in singleArray
                {
                    fileStrData += "\"" + singleString + "\""
                    if singleString != singleArray[singleArray.count-1]
                    {
                            fileStrData += ","
                        
                    }
                    
                }
                fileStrData += "\n"
                
            }
            print(fileStrData)
            
            do
{
                    try fileStrData.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
                    print("Success to Wite the File")
    
}
            catch let error as NSError
            {
                    print("Failure to Write File\n\(error)")
                
            }
            
        }
        
    }
 */

/*
//CMDeviceMotionをcsvに保存する為に用意したclass
class MotionWriter
{

    var file: FileHandle?
    var filePath: URL?
    var sample: Int = 0

    func open(_ filePath: URL)
    {
        do
{
            FileManager.default.createFile(atPath: filePath.path, contents: nil, attributes: nil)
            let file = try FileHandle(forWritingTo: filePath)
            var header = ""
            header += "acceleration_x,"
            header += "acceleration_y,"
            header += "acceleration_z,"
            header += "attitude_pitch,"
            header += "attitude_roll,"
            header += "attitude_yaw,"
            header += "gravity_x,"
            header += "gravity_y,"
            header += "gravity_z,"
            header += "quaternion_x,"
            header += "quaternion_y,"
            header += "quaternion_z,"
            header += "quaternion_w,"
            header += "rotation_x,"
            header += "rotation_y,"
            header += "rotation_z"
            header += "\n"
            file.write(header.data(using: .utf8)!)
            self.file = file
            self.filePath = filePath
    
} catch let error
{
            print(error)
    
}
        
    }

    
    func write(_ motion: CMDeviceMotion)
    {
        guard let file = self.file else { return }
        var text = ""
        text += "\(motion.userAcceleration.x),"
        text += "\(motion.userAcceleration.y),"
        text += "\(motion.userAcceleration.z),"
        text += "\(motion.attitude.pitch),"
        text += "\(motion.attitude.roll),"
        text += "\(motion.attitude.yaw),"
        text += "\(motion.gravity.x),"
        text += "\(motion.gravity.y),"
        text += "\(motion.gravity.z),"
        text += "\(motion.attitude.quaternion.x),"
        text += "\(motion.attitude.quaternion.y),"
        text += "\(motion.attitude.quaternion.z),"
        text += "\(motion.attitude.quaternion.w),"
        text += "\(motion.rotationRate.x),"
        text += "\(motion.rotationRate.y),"
        text += "\(motion.rotationRate.z)"
        text += "\n"
        file.write(text.data(using: .utf8)!)
        sample += 1
        
    }

    func close()
    {
        guard let file = self.file else { return }
        file.closeFile()
        print("\(sample) sample")
        self.file = nil
    }

    
    static func getDocumentPath() -> URL
    {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    static func makeFilePath() -> URL
    {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        let filename = formatter.string(from: Date()) + ".csv"
        let fileUrl = url.appendingPathComponent(filename)
        print(fileUrl.absoluteURL)
        return fileUrl
    }
}
*/
