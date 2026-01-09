//
//  ToDo_TaskUITests.swift
//  ToDo TaskUITests
//
//  Created by Lavonde Dunigan on 1/6/26.
//

import XCTest

final class ToDo_TaskUITests: XCTestCase {
    
    let app = XCUIApplication()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    func testLaunchzInEnglish() {
        app.launchArguments = ["-AppleLanguages", "(en)"]
        app.launch()
        
        let header = app.staticTexts ["Select the working profile"]
        XCTAssertTrue(header.exists, "The english header of 'Who is working today' is not found")
    }
    
    func testLaunchInSpanish() {
        app.launchArguments = ["-AppleLanguages", "(es)"]
        app.launch()
        
        let header = app.staticTexts ["Quien esta trabajando hoy?"]
        XCTAssertTrue(header.exists, "The spanish header of 'Who is working today' is not found")
    }
    
    func testNewGroupCreation() {
        app.launchArguments = ["-AppleLanguages", "(en)"]
        app.launch()
        
        let firstProfile = app.buttons.firstMatch
        if firstProfile.exists {
            firstProfile.tap()
            
            let addButton = app.buttons["Add"]
            if addButton.waitForExistence(timeout: 2) {
                addButton.tap()
                
                XCTAssertTrue(app.staticTexts["GROUP NAME"].exists)
                XCTAssertTrue(app.staticTexts["SELECT ICON"].exists)
                              
                              
            }
        }
        
    }
}
