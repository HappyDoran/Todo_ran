//
//  SchaduleData.swift
//  Todoran
//
//  Created by Doran on 4/13/24.
//

import Foundation
import SwiftData

@Model
final class Schedule: Identifiable {
    let id = UUID()
    var name: String
    var creationDate: Date
    var isComplete : Bool
    
    init(name : String, creationDate : Date = .now, isComplete : Bool = false) {
        self.name = name
        self.creationDate = creationDate
        self.isComplete = isComplete
    }
}


@Observable class SelectedDate {
    var date: Date = Date()
}
