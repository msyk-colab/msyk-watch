//
//  ContentView.swift
//  msyk-watch
//
//  Created by 水谷昌幸 on 2020/11/16.
//

import SwiftUI
import AVFoundation
import WatchConnectivity

var audioRecorder: AVAudioRecorder?
var audioPlayer: AVAudioPlayer?

struct ContentView: View {
    
    @State public var strStatus: String = "status"
    
    var body: some View {
        VStack {
            Text(self.strStatus)
            Button(action:{
                self.strStatus = self.startAudioRecording()
                //self.strStatus = getAudioFileURLString()
            })
                {
                Text("REC audio")
            }
            Button(action:{
                self.strStatus = self.finishAudioRecording()
            })
                {
                Text("Stop REC audio")
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
                Text("Stop Play audio")
            }
            Button(action:{
                self.strStatus = self.askReachability()
            })
                {
                Text("Watch reachable?")
            }
        }
    }

    
    func getAudioFileURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let audioURL = docsDirect.appendingPathComponent("recodringP.m4a")
        //let audioURL = docsDirect.appendingPathComponent(getDateTimeString()+".m4a")
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
            
            print("audioSession.setActive(true)")
            
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
    
    func askReachability()->String{
        var char = "None"
        if WCSession.default.isReachable == true {
            char = "Reachable."
        } else {
            char = "Not reachable."
        }
        return char
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


