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
    // MARK: 117 - 1
    
    func testUserFlow() throws {
        
        let studentCard = app.buttons["profileCard_Student"] // GIVEN pre existing data
        XCTAssertTrue(studentCard.waitForExistence(timeout: 5), "The profile of student should exist")
        studentCard.tap()
        
        let addGroupButton = app.buttons["addGroupButton"]
        XCTAssertTrue(addGroupButton.waitForExistence(timeout: 5), "The add button should be visible on the dashboard")
        addGroupButton.tap()
        
        let groupNameField = app.textFields["groupNameField"]
        XCTAssertTrue(groupNameField.waitForExistence(timeout: 2), "The Group text field should be present")
        groupNameField.tap()
        groupNameField.typeText("Testing Project")
        // Dismiss keyboard scenario
        
        if app.keyboards.buttons["Return"].exists { // if the simulator shows the keyboard
            app.keyboards.buttons["Return"].tap() // tap return to hide it after I finished typing
        } else {
            app.navigationBars["New Group Creator"].tap() // if NO keyboard shows (TODO: add accessibility ID
        }
        let iconButton = app.buttons["iconSelect_bookmark.fill"]
        if iconButton.exists {
            iconButton.tap()
        }
        let saveGroupButton = app.buttons["saveGroupButton"] // ID
        XCTAssertTrue(saveGroupButton.isHittable, "The save button is available")
        saveGroupButton.tap()
        
        let newGroupRow = app.buttons["groupRow_Testing Project"]
        XCTAssertTrue(newGroupRow.waitForExistence(timeout: 5), "The Testing Project group should be visible")
        newGroupRow.tap()
        
        let addTaskButton = app.buttons["addTaskButton"]
        XCTAssertTrue(addTaskButton.waitForExistence(timeout: 5), "The add task button should be visible")
        addTaskButton.tap()
        
        let taskTextField = app.textFields.firstMatch
        taskTextField.tap()
        taskTextField.typeText("Finish UI Test")
    }
    
    func testAddTaskButton() throws {
        app.launchArguments = ["-AppleLanguages", "(en)"]
        app.launch()

        let firstProfile = app.buttons.matching(identifier: "profileCard_Professor").firstMatch
        XCTAssertTrue(firstProfile.waitForExistence(timeout: 5))
        firstProfile.tap()

        let firstGroup = app.buttons.matching(identifier: "groupRow_Groceries").firstMatch
        XCTAssertTrue(firstGroup.waitForExistence(timeout: 5))
        firstGroup.tap()

        let addButton = app.buttons.matching(identifier: "addNewTaskButton").firstMatch
        XCTAssertTrue(addButton.exists, "The add button should be accessible")
        addButton.tap()
    }
}
