//
//  ReminderList.swift
//  Todoran
//
//  Created by Doran on 4/10/24.
//

import Foundation
import SwiftUI

struct ReminderList: Identifiable {
    let id = UUID()
    var name: String
    var reminders = [Reminder]()
    var color = Color.blue
    var iconName = "list.bullet"
}

extension ReminderList {
    static var example: ReminderList {
        ReminderList(name: "Example list", reminders: [Reminder.example])
    }
    
    static var exampleLists: [ReminderList] {
        var out = [ReminderList]()
        out.append(ReminderList(name: "Reminders", reminders: [Reminder(name: "Walk dog"), Reminder(name: "Take out trash")]))
        out.append(ReminderList(name: "Homework", reminders: [Reminder(name: "Chemistry pre-lab"), Reminder(name: "Linear algebra")], color: .red, iconName: "graduationcap"))
        out.append(ReminderList(name: "App Team", reminders: [Reminder(name: "Talk to Sam"), Reminder(name: "Collect bounty")], color: .green, iconName: "iphone.homebutton"))
        out.append(ReminderList(name: "Urgent", reminders: [Reminder(name: "Watch movie with Noah"), Reminder(name: "Eat lunch with Bob")], color: .purple, iconName: "exclamationmark.3"))
        return out
    }
    
    static var exampleToday: ReminderList {
        ReminderList(name: "Today", reminders: [Reminder(name:"Walk the dog")], color: .blue, iconName: "sun.max.fill")
    }
    
    static var exampleScheduled: ReminderList {
        ReminderList(name: "Scheduled", reminders: [Reminder(name:"Lunch with Janet")], color: .red, iconName: "calendar")
    }
    
    static var exampleFlagged: ReminderList {
        ReminderList(name: "Flagged", reminders: [], color: .yellow, iconName: "flag.fill")
    }
    
    static var exampleFinished: ReminderList {
        ReminderList(name: "Finished", reminders: [], color: .black, iconName: "hands.clap.fill")
    }
}
