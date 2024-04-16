//
//  ScheduleRowView.swift
//  Todoran
//
//  Created by Doran on 4/14/24.
//

import SwiftUI

struct ScheduleRowView: View {
    @Bindable var schedule : Schedule
    var body: some View {
        HStack {
            Button(action: {
                schedule.isComplete.toggle()
            }, label: {
                if schedule.isComplete {
                    filledReminderLabel
                }
                else{
                    emptyReminderLabel
                }
            })
            .frame(width: 20,height: 20)
            .buttonStyle(.plain)
            if schedule.isComplete {
                Text(schedule.name)
                    .font(.pretendardRegular16)
                    .foregroundColor(.gray02)
            }
            else{
                TextField(schedule.name, text: $schedule.name)
                    .font(.pretendardRegular16)
            }
        }
        .frame(height: 27)
    }
    var filledReminderLabel: some View {
        Circle()
            .stroke(Color.gray03, lineWidth: 2)
//            .bold()
            .overlay(alignment: .center) {
                GeometryReader { geo in
                    VStack {
                        Circle() // sized based on first
                            .fill(Color.gray03)
                            .frame(width: geo.size.width*0.7, height: geo.size.height*0.7, alignment: .center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
    }
    
    var emptyReminderLabel: some View {
        Circle()
            .stroke(.secondary)

    }
}
