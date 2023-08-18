//
//  iOSTakeHomeProjectApp.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 12.08.2023.
//

import SwiftUI

@main
struct iOSTakeHomeProjectApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TabView {
                PeopleView()
                    .tabItem {
                        Image(systemName: Symbols.person.rawValue)
                        Text("Home")
                    }
                
                SettingsView()
                    .tabItem {
                        Image(systemName: Symbols.gear.rawValue)
                        Text("Settings")
                    }
            }
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
#if DEBUG
        print("Is UI Test Running: \(UITestingHelper.isUITesting)")
#endif
        return true
    }
}
