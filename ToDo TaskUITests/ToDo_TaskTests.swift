//
//  ToDo_TaskTests.swift
//  ToDo Task
//
//  Created by Lavonde Dunigan on 2/2/26.
//

import XCTest
import Foundation
@testable import ToDo_Task

final class ToDo_TaskTests: XCTestCase {
    
    /* Feature: Add a calendar next to a task to have  DUE DATE */
    
    // AAA: Arrange, Act and Assert
    // Given, when, then
    
    func testTaskItemDueDate() throws {
        let testDate = Date(timeIntervalSince1970: 1735689600) // Jan 1, 2025
        
        let task = TaskItem(title: "Create Test Assignments", dueDate: testDate)
        
        XCTAssertEqual(task.dueDate, testDate)
    }
    
    // Show avisual alert/warning if a tas is overdue
    
    @Test("Task should be identified as overdue if the due date is in the past")
    func testOverdueTaskLogic() {
        let pastDue = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        
        let task = TaskItem(title: "Submit my final report", isCompleted: false, dueDate: pastDate)
        
        #expect(task.isOverdue == true, "A task with a past date and not completed should be overdue")
    }
}
