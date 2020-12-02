//
//  msyk_watchApp.swift
//  msyk-watch WatchKit Extension
//
//  Created by 水谷昌幸 on 2020/11/16.
//

import SwiftUI

@main
struct msyk_watchApp: App {
    
    // This is the business logic.
    @StateObject private var workoutManager = WorkoutManager()
    
    //https://stackoverflow.com/questions/64082376/couldnt-cast-swiftui-extensiondelegate-to-extensiondelegate
    
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self) var delegate
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.appDelegate, delegate)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}


//?
struct DelegateKey: EnvironmentKey {
    typealias Value = ExtensionDelegate?
    static let defaultValue: ExtensionDelegate? = nil
}

extension EnvironmentValues {
    var appDelegate: DelegateKey.Value {
        get {
            return self[DelegateKey.self]
        }
        set {
            self[DelegateKey.self] = newValue
        }
    }
}
//?
