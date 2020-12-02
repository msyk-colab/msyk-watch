//
//  msyk_watchApp.swift
//  msyk-watch
//
//  Created by 水谷昌幸 on 2020/11/16.
//

import SwiftUI

@main
struct msyk_watchApp: App {
    
    //https://www.swiftbysundell.com/tips/using-an-app-delegate-with-swiftui-app-lifecycle/
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    // This is the business logic.
 
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

