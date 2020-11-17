//
//  ContentView.swift
//  msyk-watch WatchKit Extension
//
//  Created by 水谷昌幸 on 2020/11/16.
//

import SwiftUI
import WatchConnectivity


struct ContentView: View {
    
    @State public var strStatus: String = "status"
    @ObservedObject var sensor = MotionSensor()
    @ObservedObject var connector = PhoneConnector()
   // var x:String
    var body: some View {
        VStack {
            ScrollView{
            Text(sensor.xStr)
            Text(sensor.yStr)
            Text(sensor.zStr)
            Button(action:{
                self.sensor.isStarted ? self.sensor.stop()
                : self.sensor.start()
            }){
                self.sensor.isStarted ? Text("STOP") : Text("START")
            }
            Button(action:{
                    self.strStatus = self.fileTransfer(fileURL: self.getSensorDataFileURL(), metaData: ["":""])
                })
                    {
                    Text("Send sensor data")
                }
                
            
                
                
            
            /*
            Button({
                self.sensor.isStarted ? self.sensor.stop() :
                    self.sensor.saveSensorDataToCsv(x)
                
               
            }
            )
            */
            
            
            
            
            
        }
    }
    }
    
    
    func getSensorDataFileURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let fileURL = docsDirect.appendingPathComponent("SensorData.csv")
        return fileURL
    }
    
    func fileTransfer(fileURL: URL, metaData: [String:String])->String{
        WCSession.default.transferFile(fileURL, metadata: metaData)
        print("success File transfer")
        return "File transfer initiated."
    }
    
    
    
    
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
