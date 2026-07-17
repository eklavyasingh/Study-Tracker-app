//
//  ContentView.swift
//  Lead Time
//
//  Created by Eklavya Singh M S on 13/07/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View{
        TabView {
            TimeTableView()
                .tabItem{
                    Label("Timetable", systemImage: "calendar")
                }
            TimerView()
                .tabItem{
                    Label("Timer", systemImage: "timer")
                }
            ProgressView()
                .tabItem{
                    Label("Progress", systemImage: "progress")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Subject.self, TimetableBlock.self, StudySession.self], inMemory: true)
}
