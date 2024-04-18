//
//  FlagView.swift
//  Todoran
//
//  Created by Doran on 4/11/24.
//

import SwiftUI
import SwiftData
import Charts

struct FlagView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var schedules : [Schedule]
    var body: some View {
        VStack(alignment:.leading){
            headerView
            ScrollView{
                VStack(alignment:.leading){
                    Divider()
                    ChartView()
                        .padding(.top,20)
                    
                    Divider()
                    scheduleView
                }
            }
            .scrollDisabled(true)
        }
        .padding(16)
    }
    
    private var headerView: some View {
        Section{
            Text("Todo-ran")
                .font(.pretendardBold32)
                .padding(.bottom,2)
                .padding(.top,7)
            Text("뿌듯하신가요?")
                .font(.pretendardSemiBold14)
        }
    }
    
    private var scheduleView: some View {
        Section{
            Text("지난날의 뿌듯함")
                .font(.pretendardSemiBold18)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 3, trailing: 0))
            
            let filteredSchedules = schedules.filter {
                $0.isComplete == true
            }
            
            if filteredSchedules.isEmpty {
                Text("해당 일정이 없습니다.")
                    .font(.pretendardRegular16)
                    .foregroundColor(.gray02)
                    
            }
            
            ForEach(filteredSchedules) { item in
                ScheduleRowView(schedule: item)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom,10)
                    .overlay(BottomBorder().stroke(Color.gray01, lineWidth: 1))
            }
        }
    }
}

#Preview {
    FlagView()
        .modelContainer(previewContainer)
}

