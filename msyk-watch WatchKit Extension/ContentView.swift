//
//  ContentView.swift
//  msyk-watch WatchKit Extension
//
//  Created by 水谷昌幸 on 2020/11/16.
//

import SwiftUI
import WatchConnectivity
import HealthKit
import AVFoundation

var audioRecorder: AVAudioRecorder?
var audioPlayer: AVAudioPlayer?


struct ContentView: View {
    
    var valueSensingIntervals = [60,10,5.0,2.0,1.0,0.5,0.1,0.05,0.01]
    var Choises = ["MotionData","WorkOut","MotionData&WorkOut"]
    
    @State public var strStatus: String = "status"
    @State private var intSelectedInterval: Int = 0
    @State private var strChoise: String = "MotionData"
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession!
    
    @ObservedObject var sensor = MotionSensor()
    //@ObservedObject var connector = PhoneConnector()
    
    var body: some View {
        VStack {
            ScrollView{
                Text(self.strStatus)
                Text(sensor.xStr)
                Text(sensor.yStr)
                Text(sensor.zStr)
                //音声取得
                /*
                Button(action:{
                    self.strStatus = self.startAudioRecording()
                })
                    {
                    Text("REC audio")
                }
                Button(action:{
                    self.strStatus = self.finishAudioRecording()
                })
                    {
                    Text("Stop REC")
                }
                Button(action:{
                    self.strStatus = self.playAudio()
                    //self.strStatus = getAudioFileURLString()
                })
                    {
                    Text("Play audio")
                }
                Button(action:{
                    self.strStatus = self.finishPlayAudio()
                })
                    {
                    Text("Stop Play")
                }
                Button(action:{
                    self.strStatus = self.fileTransfer(fileURL: self.getAudioFileURL(), metaData: ["":""])
                })
                    {
                    Text("Send audio file")
                }
                 */
                
                
                //データ更新間隔を指定
                Picker("Sensing interval [s]", selection: $intSelectedInterval){
                    ForEach(0 ..< valueSensingIntervals.count) {
                        Text(String(self.valueSensingIntervals[$0]))
                    }
                }.frame(height: 40)
                
                /*
                //取得するデータ種類を選択
                Picker("Choises", selection: $strChoise){
                    ForEach(0 ..< Choises.count) {
                        Text(String(self.Choises[$0]))
                    }
                }.frame(height: 40)
                */
                
                
                Button(action:{

                    self.strStatus = self.sensor.startSensorUpdates(intervalSeconds: self.valueSensingIntervals[self.intSelectedInterval])
                    //self.startWorkoutSession()
                })
                    {
                    Text("Start sensor DAQ")
                }
                
                Button(action:{
                    self.strStatus = self.sensor.stopSensorUpdates()
                    //self.stopWorkoutSession()
                    //self.sensor.stop()
                })
                    {
                    Text("Stop sensor DAQ")
                }
                
                /*
            Button(action:{
                self.sensor.isStarted self.sensor.stop()
                : self.sensor.start()
            }){
                self.sensor.isStarted ? Text("STOP") : Text("START")
            }
                */
                
            Button(action:{
                    self.strStatus = self.fileTransfer(fileURL: self.getSensorDataFileURL(), metaData: ["":""])
                })
                    {
                    Text("Send sensor data")
                }
                
            }
        }
    }
    
    
//音声取得関数
    /*
    func getAudioFileURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let audioURL = docsDirect.appendingPathComponent("recodringW.m4a")
        let audioURL = docsDirect.appendingPathComponent(getDateTimeString()+".m4a")
        return audioURL
    }
    
    
    
    func startAudioRecording()-> String{
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            let settingsDictionary = [
                AVFormatIDKey:Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            try audioSession.setActive(true)
            audioRecorder = try AVAudioRecorder(url:getAudioFileURL(),settings: settingsDictionary)
            audioRecorder!.record()
            return "REC audio in progress"
        }
        catch {
            return "REC audio error"
        }
    }
    
    func finishAudioRecording()->String{
        audioRecorder?.stop()
        return "Finished."
    }
    
    func playAudio()->String{
        let url = getAudioFileURL()
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            audioPlayer = sound
            sound.prepareToPlay()
            sound.play()
            return "PLY audio started."
        }
        catch {
            return "PLY audio error."
        }
    }
    
    func finishPlayAudio()->String{
        audioPlayer?.stop()
        return "Finished."
    }
    */
    
     
    func getSensorDataFileURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let fileURL = docsDirect.appendingPathComponent("SensorData.csv")
        return fileURL
    }
    
    func fileTransfer(fileURL: URL, metaData: [String:String])->String{
        WCSession.default.transferFile(fileURL, metadata: metaData)
        print("File transfer initiated")
        return "File transfer initiated."
    }
    
    /*
    //ワークアウト用関数
    func startWorkoutSession() {
        let config = HKWorkoutConfiguration()
        config.activityType = .other
        do {
            let session = try HKWorkoutSession(healthStore: self.healthStore, configuration: config)
            session.startActivity(with: nil)
        } catch {
            // Handle exceptions.
        }
    }

    func stopWorkoutSession() {
        guard let workoutSession = self.session else { return }
        workoutSession.stopActivity(with: nil)
    }
*/
    
    
    
    /*
    /// ファイル書き込みサンプル
    func writingToFile(text: String)
    {
         /// ①DocumentsフォルダURL取得
        /// DocumentsフォルダURLを取得
         guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else
         {
             fatalError("フォルダURL取得エラー")
         }
         /// ②対象のファイルURL取得
         let fileURL = dirURL.appendingPathComponent("output.csv")
  
         /// ③ファイルの書き込み
         do {
             try text.write(to: fileURL, atomically: true, encoding: .utf8)
         } catch {
             print("Error: \(error)")
         }
     }
     */
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
