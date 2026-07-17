//
//  StudyTrackerApp.swift
//  Lead Time
//
//  Created by Eklavya Singh M S on 15/07/26.
//

import SwiftUI
import SwiftData

@main
struct StudyTrackerApp: App {
    var body: some Scene {
        WindowGroup{
            ContentView()
        }
        .modelContainer(for :[Subject.self, TimetableBlock.self, StudySession.self])
    }
}
