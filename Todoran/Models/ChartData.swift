//
//  ChartData.swift
//  Todoran
//
//  Created by Doran on 4/15/24.
//

import Foundation

struct ChartData: Identifiable {
    let id = UUID()
    let isComplete: String
    let ratio: Double
}
