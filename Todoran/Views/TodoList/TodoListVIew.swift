//
//  TodoListVIew.swift
//  Todoran
//
//  Created by Doran on 4/10/24.
//

import SwiftUI

struct TodoListView: View {
    @State var reminderLists = ReminderList.exampleLists
    @State var exampleToday = ReminderList.exampleToday
    @State var exampleScheduled = ReminderList.exampleScheduled
    @State var exampleFlagged = ReminderList.exampleFlagged
    @State var exampleFinished = ReminderList.exampleFinished
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        VStack {
                            HStack {
                                ListCardView(reminderList: $exampleToday)
                                ListCardView(reminderList: $exampleScheduled)
                            }
                            HStack {
                                ListCardView(reminderList: .constant(allReminders))
                                ListCardView(reminderList: $exampleFlagged)
                            }
                            HStack{
                                ListCardView(reminderList: $exampleFinished)
                                Spacer().frame()
                            }
                        }
                    }
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
                    .listRowInsets(EdgeInsets())
                    Section {
                        ForEach($reminderLists){ $reminders in
                            NavigationLink {
                                ReminderListView(reminderList: $reminders)
                                
                            } label: {
                                ReminderListListRowView(reminderList: reminders)
                            }
                            .listRowInsets(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 15))
                            
                        }
                    } header: {
                        Text("My Lists")
                            .font(.system(.title3, design: .rounded, weight: .bold))
                            .foregroundColor(.primary)
                    }
                }
                .navigationTitle("Reminders")
            }
        }
        
    }
    
    var allReminders: ReminderList {
        var allReminders = [Reminder]()
        for reminderList in reminderLists {
            for reminder in reminderList.reminders {
                allReminders.append(reminder)
            }
        }
        return ReminderList(name: "All", reminders: allReminders, color: .gray, iconName: "tray.fill")
    }
    
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}

