//
//  WatchConnector.swift
//  msyk-watch
//
//  Created by 水谷昌幸 on 2020/11/16.
//

import Foundation
import UIKit
import WatchConnectivity
/*
class WatchConnector: NSObject, ObservableObject, WCSessionDelegate {
   
    /*
    @Published var receivedMessage = "WATCH : 未受信"
    @Published var count = 0

    override func viewDidLoad()
    {
      super.viewDidLoad()
        if WCSession.isSupported()
        {
    //WCSessionが存在する場合のみ実行
        let session = WCSession.default
        session.delegate = self
        session.activate()
        
        }
        
    }
    */
    
    
    
    
    override init()
    {
        super.init()
        if WCSession.isSupported()
        {
            WCSession.default.delegate = self
            WCSession.default.activate()
            
        }
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith state= \(activationState.rawValue)")
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
    /*
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("didReceiveMessage: \(message)")
        
        DispatchQueue.main.async {
            self.receivedMessage = "WATCH : \(message["WATCH_COUNT"] as! Int)"
        }
    }
    func send() {
        if WCSession.default.isReachable {
            count += 1
            WCSession.default.sendMessage(["PHONE_COUNT" : count], replyHandler: nil) { error in
                print(error)
            }
        }
    }
    */

    //User Info Transfer受信
    private func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        print("success")
        // 処理
    }
    
}
*/
