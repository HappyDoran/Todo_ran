//
//  HomeView.swift
//  Todoran
//
//  Created by Doran on 4/10/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @Query private var schedules : [Schedule]
    @Bindable var selectedDate: SelectedDate
    
    
    @State private var selectedView: String = "home"
    @State private var isHomeActive = false
    @State private var isCheckmarkActive = false
    @State private var isFlagActive = false
    
    
    var body: some View {
        VStack(alignment:.leading){
            headerView
            
            ScrollView(showsIndicators: false){
                LazyVStack(alignment:.leading){
                    Divider()
                    CalendarView(selectedDate : selectedDate, month: Date())
                        .padding(.top,20)
                    
                    Divider()
                    scheduleView
                }
            }
        }
//        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        .padding(16)
    }
    
    private var headerView: some View {
        Section{
            Text("Todo-ran")
                .font(.pretendardBold32)
                .padding(.bottom,2)
                .padding(.top,7)
            Text("당신의 하루는 뿌듯한가요?")
                .font(.pretendardSemiBold14)
        }
    }
    
    private var scheduleView: some View {
        Section{
            Text("그때의 뿌듯함")
                .font(.pretendardSemiBold18)
                .padding(.top,10)
                .padding(3)
            
            let filteredSchedules = schedules.filter {
                Calendar.current.isDate($0.creationDate, inSameDayAs: selectedDate.date)
            }
            
            
            if filteredSchedules.isEmpty {
                Text("해당 일정이 없습니다.")
                    .font(.pretendardRegular16)
                    .foregroundColor(.gray02)
                    .padding(.leading,3)
                    
            }
            else{
                ForEach(filteredSchedules)
                { item in
                    ScheduleRowView(schedule: item)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom,10)
                        
//                    Divider()
                        .overlay(BottomBorder().stroke(colorScheme == .dark ? Color.dividerColor : Color.gray01, lineWidth: 1))
                }
            }
        }
    }
}


struct BottomBorder: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        return path
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView( selectedDate: SelectedDate())
            .modelContainer(previewContainer)
//            .preferredColorScheme(.dark) //프리뷰 다크모드
    }
}
