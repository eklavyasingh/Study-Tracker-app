//
//  Models.swift
//  Lead Time
//
//  Created by Eklavya Singh M S on 13/07/26.
//

import Foundation
import SwiftData

@Model
final class Subject {
    var id: UUID
    var name: String
    var colorHex:String
    
    init(name: String, colorHex:String="4A90D9"){
        self.id = UUID()
        self.name=name
        self.colorHex=colorHex
    }
}

// enum weekdays

enum Weekday: Int, Codable, CaseIterable, Identifiable{
    case sunday=1, monday, tuesday, wednesday, thursday, friday, saturday
    
    var id: Int{rawValue}
    
    var shortName:String{
        switch self{
        case .sunday: return "Sun"
        case .monday: return "Mon"
        case .tuesday: return "Tue"
        case .wednesday: return "Wed"
        case .thursday: return "Thu"
        case .friday: return "Fri"
        case .saturday: return "Sat"
            
        }
    }
}

enum Priority: String, Codable {
    case low
    case medium
    case high
}

// Mark : - timetable block
// A recurring weekly slot , eg " Math subject monday 5-6 pm"

@Model
final class TimetableBlock{
    var id: UUID
    var subjectName: String
    var weekday: Weekday
    var startHour: Int
    var startMinute: Int
    var durationMinutes: Int
    var isActive: Bool
    var priority: Priority
    
    init(subjectName: String, weekday: Weekday, startHour: Int, startMinute: Int, durationMinutes: Int, priority: Priority = .medium) {
        self.id = UUID()
        self.subjectName = subjectName
        self.weekday = weekday
        self.startHour = startHour
        self.startMinute = startMinute
        self.durationMinutes = durationMinutes
        self.isActive = true
        self.priority = priority
    }
    
    // convinience for display like 5:00 PM
    var startTimeLabel: String {
        var components = DateComponents()
        components.hour = startHour
        components.minute = startMinute
        let calendar = Calendar.current
        let date = calendar.date(from: components) ?? Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from : date)
    }
    
    var priorityLabel: String {
        switch priority {
        case .low: return "🟢 Low"
        case .medium: return "🟡 Medium"
        case .high: return "🔴 High"
        }
    }
}

// MARK : SessionType

enum SessionType: String, Codable {
    case study
    case breakTime
}

// Mark study session
// Alogged session, either linked to a planned timetableblock, or ad-hoc

@Model
final class StudySession{
    var id: UUID
    var subjectName: String
    var type: SessionType
    var startedAt: Date
    var endedAt: Date?
    var plannedDurationMinutes: Int     //what was scheduled /intended
    var linkedBlockID: UUID?             //nil if this was an unplanned/ad hoc session
    
    init(subjectName: String, type: SessionType, plannedDurationMinutes: Int, linkedBlockID: UUID? = nil){
        self.id = UUID()
        self.subjectName = subjectName
        self.type = type
        self.startedAt = Date()
        self.endedAt = nil
        self.plannedDurationMinutes = plannedDurationMinutes
        self.linkedBlockID = linkedBlockID
    }
    
    var actualDurationMinutes: Int{
        guard let endedAt else {return 0}
        return Int(endedAt.timeIntervalSince(startedAt) / 60)
    }
    
    var isCompleted: Bool { endedAt != nil }
    
    // Did the user roughly hit the planned time? (within 20% under is still a "win")
    var metGoal: Bool {
        guard isCompleted else { return false }
        return Double(actualDurationMinutes) >= Double (plannedDurationMinutes) * 0.8
    }
}



