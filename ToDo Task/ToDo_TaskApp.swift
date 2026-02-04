//
//  ToDo_TaskApp.swift
//  ToDo Task
//
//  Created by Lavonde Dunigan on 12/11/25.
//

import SwiftUI

@main
struct ToDo_TaskApp: App {
    @StateObject private var languageManager = LanguageManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(languageManager)
        }
    }
}
