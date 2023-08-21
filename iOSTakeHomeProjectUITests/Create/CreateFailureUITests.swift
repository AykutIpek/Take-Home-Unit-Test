//
//  CreateFailureUITests.swift
//  iOSTakeHomeProjectUITests
//
//  Created by aykut ipek on 21.08.2023.
//

import XCTest

final class CreateFailureUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-people-networking-success":"1",
            "-create-networking-success":"0"
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_alert_is_shown_when_submission_fails() {
        let createBtn = app.buttons["createBtn"]
        XCTAssertTrue(createBtn.waitForExistence(timeout: 5), "There create button should be visible on the screen")
        
        createBtn.tap()
        
        let firstNameTxtFields = app.textFields["firstNameTxtFields"]
        let lastnameTxtFields = app.textFields["lastNameTxtFields"]
        let jobTxtFields = app.textFields["jobTxtFields"]
        
        firstNameTxtFields.tap()
        firstNameTxtFields.typeText("Aykut")

        lastnameTxtFields.tap()
        lastnameTxtFields.typeText("Ipek")
        
        jobTxtFields.tap()
        jobTxtFields.typeText("iOS Developer")
        
        let submitBtn = app.buttons["submitBtn"]
        XCTAssertTrue(submitBtn.exists, "There create button should be visible on the screen")
        
        submitBtn.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        
        XCTAssertTrue(alert.staticTexts["URL isn't valid"].exists)
        XCTAssertTrue(alert.buttons["OK"].exists)
    }
    
}
