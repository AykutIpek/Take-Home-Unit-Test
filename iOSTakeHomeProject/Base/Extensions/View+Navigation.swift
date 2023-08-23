//
//  View+Navigation.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 23.08.2023.
//

import SwiftUI


extension View {
    @ViewBuilder
    func embedInNavigation() -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                self
            }
        } else {
            NavigationView {
                self
            }
        }
    }
}
