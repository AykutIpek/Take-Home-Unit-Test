//
//  iOSTakeHomeProjectApp.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 12.08.2023.
//

import SwiftUI

@main
struct iOSTakeHomeProjectApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                PeopleView()
                    .tabItem {
                        Image(systemName: Symbols.person.rawValue)
                        Text("Home")
                    }
            }
        }
    }
}
