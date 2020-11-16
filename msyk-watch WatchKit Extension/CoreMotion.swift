//
//  CoreMotion.swift
//  msyk-watch WatchKit Extension
//
//  Created by 水谷昌幸 on 2020/11/16.
//

import Foundation

import Foundation
import UIKit
import CoreMotion
import WatchConnectivity
import WatchKit


class MotionSensor: NSObject,ObservableObject
{

    
    private(set) var isRecording = false
    private let headerText = "timestamp,attitudeX,attitudeY,attitudeZ,gyroX,gyroY,gyroZ,gravityX,gravityY,gravityZ,accX,accY,accZ"
    private var recordText = ""
    var format = DateFormatter()
   
    
/*
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?)
    {
     code
    }
    */
    
    
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
    
    
    
    let motionManager = CMMotionManager()
    //デバイスがモーションデータに対応しているかどうか
    //データ更新間隔を指定
    //データ取得の開始と、データ更新時に呼び出される関数を指定
    func start()
    {
        recordText = ""
        recordText += headerText + "\n"
  
        
        if motionManager.isDeviceMotionAvailable
        {
            motionManager.deviceMotionUpdateInterval = 1
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
                self.updateMotionData(deviceMotion: motion!)})
           // self.saveSensorDataToCsv(fileName: x)
        }
    //isStartedをフラグとして使い、「start()」時にtrue、「stop()」時にfalse
        isStarted = true
    }
    
    
    func stop()
    {
        isStarted = false
        motionManager.stopDeviceMotionUpdates()
        print(isStarted)
        //配列をcsvにして保存する関数を呼び出す
        self.saveSensorDataToCsv(fileName: tempx)
       // self.connector.send()
    }
    
    
    //更新のたびにx, y, z方向への加速度を、xStr, yStr, zStrに文字列として格納
    private func updateMotionData(deviceMotion:CMDeviceMotion)
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
