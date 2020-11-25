//
//  PhoneConnector.swift
//  msyk-watch WatchKit Extension
//
//  Created by 水谷昌幸 on 2020/11/16.
//

import Foundation
import CoreMotion
import UIKit
import WatchConnectivity
/*
 
 

class PhoneConnector: NSObject, ObservableObject, WCSessionDelegate {
    
    @Published var receivedMessage = "PHONE : 未受信"
    @Published var count = 0
    @Published var userInfo = ["test" : "テスト"]
    
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
    
    
    //受信操作？
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith state= \(activationState.rawValue)")
    }
    
    //受信操作？
    /*
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("didReceiveMessage: \(message)")
        
        DispatchQueue.main.async {
            self.receivedMessage = "PHONE : \(message["PHONE_COUNT"] as! Int)"
        }
    }
    */
    
    
    
    /*
    func send() {
        if WCSession.default.isReachable {
            count += 1
            WCSession.default.sendMessage(["WATCH_COUNT" : count], replyHandler: nil) { error in
                print(error)
            }
        }
    }
    */
    /*
    //User Info Transfer送信
    let userInfo = ["test" : "テストだよ"]
    let transfer = WCSession.defaultSession().transferUserInfo(userInfo)
    */
    
/*
    if WCSession.isSupported()
    {
    //User Info Transfer送信
    let userInfo = ["test" : "テストだよ"]
    let transfer = WCSession.defaultSession().transferUserInfo(userInfo)
    }
*/
/*
    func send() {
        if WCSession.default.isReachable
        {
            //count += 1
        //    WCSession.default.sendMessage(["PHONE_COUNT" : count], replyHandler: nil)
            //let userInfo = ["test" : "テストだよ"]
            //let transfer=
            //WCSession.defaultSession.transferUserInfo(userInfo)
            
         
            //{error in print(error)
                
            
            /*
            func send() {
                if WCSession.default.isReachable {
                    //count += 1
                    WCSession.default.sendMessage(["WATCH_COUNT" : count], replyHandler: nil) { error in
                        print(error)
                    }
                }
            }
 */
            
            func transferFile
            (_ file: URL,
             metadata: [String : Any]?) -> WCSessionFileTransfer{}
                
             
            { error in
               print(error)
           }
            
            }
        }
*/
    
/*
func send() {
    if WCSession.default.isReachable {
        count += 1
    WCSession.default.transferFile(NSHomeDirectory() + "/Documents/" + fileName + ".csv": URL),filePath: [String : Any]?) ->WCSessionFileTransfer
        { error in
        print(error)
    }
    }
}
print(WCSession.default.isReachable)
}
*/
}

 
 
 
 */
