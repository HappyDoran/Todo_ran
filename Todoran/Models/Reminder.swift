//
//  Reminder.swift
//  Todoran
//
//  Created by Doran on 4/10/24.
//

import Foundation

struct Reminder: Identifiable {
    let id = UUID()
    var name: String
    var isComplete = false
    
}

extension Reminder {
    static var example: Reminder {
        Reminder(name: "Example reminder")
    }
}

