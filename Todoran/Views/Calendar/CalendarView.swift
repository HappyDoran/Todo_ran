//
//  CalendarView.swift
//  Todoran
//
//  Created by Doran on 4/10/24.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var schedules : [Schedule]
    @Bindable var selectedDate : SelectedDate
    
    @State var month: Date
    @State var offset: CGSize = CGSize()
    @State var clickedDates: Set<Date> = []
    //    @State var  scheduleModel : ScheduleItem
    
    
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
        }
//        .padding(.horizontal,16)
    }
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack {
//                Spacer(minLength:70)
                Text(month, formatter: Self.dateFormatter)
                    .font(.pretendardSemiBold24)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading,15)
                
//                Spacer(minLength: 180)
                
                Button(action: { changeMonth(by: -1) }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.pink04)
                })
                
                Button(action: { changeMonth(by: 1) }, label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.pink04)
                })
//                .padding([.leading, .trailing], 15)
            }
            .padding(.bottom)
            HStack {
                ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 5)
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let today = Calendar.current.startOfDay(for: Date()) // 오늘 날짜의 시작 부분을 가져옵니다.
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        
        return VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(0..<daysInMonth + firstWeekday, id: \.self) { index in
                    if index < firstWeekday {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.clear)
                    } else {
                        let date = getDate(for: index - firstWeekday)
                        let day = index - firstWeekday + 1
                        let clicked = selectedDate.date == date // 클릭된 날짜와 현재 날짜가 같은지 비교
                        let isToday = Calendar.current.isDate(date, inSameDayAs: today)
                        
                        // 해당 날짜에 이벤트가 있는지 확인
                        let hasEvent = schedules.contains(where: { schedule in
                            Calendar.current.isDate(schedule.creationDate, inSameDayAs: date)
                        })
                        //                        CellView(date: date, day: day, clicked: clicked, isToday: isToday)
                        CellView(date: date, day: day, clicked: clicked, isToday: isToday, hasEvent: hasEvent)
                            .onTapGesture {
                                if !Calendar.current.isDate(selectedDate.date, inSameDayAs: date) {
                                    selectedDate.date  = date
                                }
                            }
                    }
                }
            }
        }
    }
}

// MARK: - 일자 셀 뷰
private struct CellView: View {
    @State var date: Date
    
    var day: Int
    var clicked: Bool = false
    var isToday: Bool = false // 현재 날짜 여부를 나타내는 새로운 매개변수
    var hasEvent: Bool = false
    
    var body: some View {
        VStack {
            ZStack{
                if isToday {
                    Circle()
                        .frame(width: 30,height: 30)
                        .foregroundColor(Color.todayDate)
                    RoundedRectangle(cornerRadius: 5)
                        .opacity(0)
                        .overlay(Text(String(day)))
                        .foregroundColor(.white)
                }
                else{
                    Circle()
                        .frame(width: 20,height: 20)
                        .foregroundColor(.clear)
                    RoundedRectangle(cornerRadius: 5)
                        .opacity(0)
                        .overlay(Text(String(day)))
                        .foregroundColor(.primary)
                }
                
                if clicked {
                    Circle()
                        .frame(width: 30,height: 30)
                        .foregroundColor(Color.selectDate)
                    RoundedRectangle(cornerRadius: 5)
                        .opacity(0)
                        .overlay(Text(String(day)))
                        .foregroundColor(.white)
                }
                else{
                    Circle()
                        .frame(width: 8,height: 8)
                        .foregroundColor(.clear)
                }
                
            }
            if hasEvent {
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(Color.scheduleDot)
            }
            else{
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.clear)
            }
        }
        .frame(height: 45)
//        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}


// MARK: - 내부 메서드
private extension CalendarView {
    /// 특정 해당 날짜
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
    }
    
    /// 해당 월의 시작 날짜
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: components)!
    }
    
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇 번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
            self.month = newMonth
        }
    }
}

// MARK: - Static 프로퍼티
extension CalendarView {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    static let weekdaySymbols = Calendar.current.veryShortWeekdaySymbols
}

#Preview {
    //    CalendarView(selectedDate: SelectedDate(), month: Date(), scheduleModel: ScheduleItem.init())
    CalendarView(selectedDate: SelectedDate(), month: Date())
        .modelContainer(previewContainer)
}

