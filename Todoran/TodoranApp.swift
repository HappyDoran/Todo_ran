//
//  TodoranApp.swift
//  Todoran
//
//  Created by Doran on 4/10/24.
//

import SwiftUI
import SwiftData

@main
struct TodoranApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Schedule.self)
    }
}
