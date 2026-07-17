//
//  TimeTableView.swift
//  Lead Time
//
//  Created by Eklavya Singh M S on 13/07/26.
//

import SwiftUI
import SwiftData

struct TimeTableView: View{
    @Query(sort: \TimetableBlock.startHour) private var blocks: [TimetableBlock]
    var body: some View {
        List {
            ForEach(Weekday.allCases) { day in
                Text(day.shortName)
            }
        }
    }

}

#Preview {
    TimeTableView()
        .modelContainer(for: [Subject.self, TimetableBlock.self, StudySession.self], inMemory: true)
}

