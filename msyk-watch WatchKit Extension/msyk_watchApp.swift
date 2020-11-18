//
//  msyk_watchApp.swift
//  msyk-watch WatchKit Extension
//
//  Created by 水谷昌幸 on 2020/11/16.
//

import SwiftUI

@main
struct msyk_watchApp: App {
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

