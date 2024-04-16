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
            Text("Todo-ran")
                .font(.pretendardBold32)
                .padding(EdgeInsets(top: 10, leading: 16, bottom: 0, trailing: 16))
            ScrollView{
                VStack(alignment:.leading){
                Rectangle()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: 1)
                    .foregroundColor(.gray02)
                    .padding(.horizontal,16)
                    Text("뿌듯하신가요?")
                        .font(.pretendardSemiBold16)
                        .padding(.horizontal,16)
                ChartView()
                        .padding(.bottom,10)
                    Text("지난날의 뿌듯함")
                        .font(.pretendardSemiBold16)
                        .padding(.horizontal,16)
                    Spacer()
                        .padding(.bottom,5)
                    
                    ForEach(schedules.filter {
                        $0.isComplete == true
                    }) { item in
                        ScheduleRowView(schedule: item)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom,5)
                            .overlay(BottomBorder().stroke(Color.gray01, lineWidth: 1))
                            .padding(.horizontal,16)
                    }
                }
            }
        }
    }
}

#Preview {
    FlagView()
        .modelContainer(previewContainer)
}

