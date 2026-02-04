//
//  TaskModels.swift
//  ToDo Task
//
//  Created by Lavonde Dunigan on 12/11/25.
//
import Foundation

enum Priority: String, Codable {
    case high, medium, low
}

struct TaskItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    var dueDate: Date?
    var isOverdue: Bool {
        guard let dueDate = dueDate, !isCompleted else { return false }
        return dueDate < Date()
    }
    var priority: Priority = .low
}

struct TaskGroup: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
    var createdAt: Date = Date()
}

struct TaskProfile: Identifiable, Hashable, Codable {
    var id = UUID()
    var name:String
    var profileImage: String
    var group: [TaskGroup]
}

// MOCK DATA
extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(title: "Groceries",
            symbolName: "storefront.circle.fill",
            tasks: [
            TaskItem(title: "Buy Apples"),
            TaskItem(title: "Buy Milk")
        ]),
        
        TaskGroup(title: "Home",
            symbolName: "house.fill",
            tasks: [
                TaskItem(title: "Walk the dog", isCompleted: true ),
                TaskItem(title: "Clean the kitchen")
        ])
    ]
}
extension TaskProfile {
    static let sample: [TaskProfile] = [
        TaskProfile(name: "Professor", profileImage: "professor", group: TaskGroup.sampleData),
        TaskProfile(name: "Student", profileImage: "student", group: [])
    ]
}

