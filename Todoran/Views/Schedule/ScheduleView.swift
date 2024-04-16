//
//  ScheduleView.swift
//  Todoran
//
//  Created by Doran on 4/11/24.
//

import SwiftUI
import SwiftData


struct ScheduleView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var schedules : [Schedule]
    @Bindable var selectedDate: SelectedDate
    
    var body: some View {
        VStack(alignment:.leading){
            headerView
            
            DatePicker("", selection: $selectedDate.date, displayedComponents: .date)
                .labelsHidden()
                .frame(width: 150, height: 80, alignment: .leading)
                .padding(.horizontal,16)
                .accentColor(Color.pink01)
                .clipped()
                .padding(.top,20)
            
            scheduleView
            
            Button(action: {
                let newSchedule = Schedule(name: "",creationDate: selectedDate.date, isComplete: false)
                modelContext.insert(newSchedule)
            }, label: {
                HStack(spacing: 7) {
                    Image(systemName: "plus.circle.fill")
                    Text("New Schedule")
                    
                }
                .padding(.horizontal,16)
            })
        }
        //        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        .padding([.top,.bottom,],16)
    }
    
    private var headerView: some View {
        Text("Todo-ran")
            .font(.pretendardBold32)
            .padding(.horizontal,16)
            .padding(.top,7)
    }
    
    private var scheduleView : some View {
        List{
            ForEach(schedules.filter {
                Calendar.current.isDate($0.creationDate, inSameDayAs: selectedDate.date)
            }) { item in
                ScheduleRowView(schedule: item)
            }
            .onDelete(perform: delete)
            .navigationBarBackButtonHidden(true)
//            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        }
//        .frame(height: 30*CGFloat(Int(schedules.count)))
        .listStyle(.inset)
    }
}

extension ScheduleView{
    func delete(_ indexSets: IndexSet) {
        for index in indexSets {
            print(index)
            let schedule = schedules[index]
            modelContext.delete(schedule)
            
            
            do {
                try modelContext.save()
            }
            catch {
                print("Error saving : \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ScheduleView(selectedDate: SelectedDate.init())
//    ScheduleView()
        .modelContainer(previewContainer)
}

