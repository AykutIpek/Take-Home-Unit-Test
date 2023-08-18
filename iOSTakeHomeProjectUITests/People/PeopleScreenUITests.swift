//
//  PeopleScreenUITests.swift
//  iOSTakeHomeProjectUITests
//
//  Created by aykut ipek on 18.08.2023.
//

import XCTest

final class PeopleScreenUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-networking-success":"1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_dummy() {
        XCTFail()
    }
}
