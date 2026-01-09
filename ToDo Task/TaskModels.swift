//
//  TaskModels.swift
//  ToDo Task
//
//  Created by Lavonde Dunigan on 12/11/25.
//
import Foundation

struct TaskItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct TaskGroup: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

struct Profile: Identifiable, Hashable, Codable {
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
extension Profile {
    static let sample: [Profile] = [
        Profile(name: "Professor", profileImage: "professor", group: TaskGroup.sampleData),
        Profile(name: "Student", profileImage: "student", group: [])
    ]
}

