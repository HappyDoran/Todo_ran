//
//  ChartView.swift
//  Todoran
//
//  Created by Doran on 4/15/24.
//

import SwiftUI
import SwiftData
import Charts

struct ChartView: View {
    @Query private var schedules: [Schedule]
        
        @State private var animatedCompletedRatio: Double = 0
        
        var body: some View {
            let completedRatio = Double(schedules.filter{$0.isComplete == true}.count)
            
            let chartData: [ChartData] = [
                ChartData(isComplete: "완료", ratio: animatedCompletedRatio),
                ChartData(isComplete: "미완료", ratio: Double(schedules.count) - animatedCompletedRatio)
            ]
            let totalRatio : Double = completedRatio / Double(schedules.count) * 100
        ZStack{
            Chart(chartData) { chartData in
                SectorMark(
                    angle: .value(
                        "isComplete",
                        chartData.ratio
                    ),
                    innerRadius: .ratio(0.5),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(
                    by: .value(
                        "isComplete",
                        chartData.isComplete
                    )
                )
            }
            .chartForegroundStyleScale(
                range: Gradient(colors: [ Color.pink04,Color.white])
            )
            Circle()
                .frame(height: 200)
                .offset(x:0,y:-9)
                .foregroundColor(.pink05)
            Text("\(totalRatio, specifier: "%.0f")%")
                .font(.pretendardBold32)
                .offset(x:10,y:-10)
        }
        .frame(height: 300)
        .padding(.horizontal,16)
        .onAppear {
            withAnimation(.linear(duration: 0.5)) {
                self.animatedCompletedRatio = completedRatio
            }
        }
    }
}

#Preview {
    ChartView()
        .modelContainer(previewContainer)
}
