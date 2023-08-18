//
//  UITestingHelper.swift
//  iOSTakeHomeProject
//
//  Created by aykut ipek on 18.08.2023.
//


#if DEBUG
import Foundation

struct UITestingHelper {
    
    static var isUITesting: Bool {
//        ProcessInfo.processInfo.arguments.contains("-ui-testing")
        return true
    }
    
}
#endif
