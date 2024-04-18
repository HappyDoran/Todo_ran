//
//  MainView.swift
//  Todoran
//
//  Created by Doran on 4/10/24.
//

import SwiftUI

class TabSelection: ObservableObject {
    @Published var selectedTab: Int = 0
}

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    
    @StateObject var tabSelection = TabSelection()
    @State var selectedDate : SelectedDate
    

    var body: some View {
                TabView(selection: $tabSelection.selectedTab) {
                    HomeView(selectedDate: selectedDate)
                        .tabItem {
                        Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .tag(0)
                        .toolbarBackground(
                            Color.black,
                            for: .tabBar)
                    ScheduleView(selectedDate: selectedDate)
                        .tabItem {
                            Image(systemName: "note.text")
                            Text("Check")
                        }
                        .tag(1)
                        .toolbarBackground(
                            Color.black,
                            for: .tabBar)
                    FlagView()
                        .tabItem {
                            Image(systemName: "flag.fill")
                            Text("Completed")
                        }
                        .tag(2)
                        .toolbarBackground(
                            Color.black,
                            for: .tabBar)
                }
                .accentColor(.pink)
            }
    
}

#Preview {
    MainView(selectedDate: SelectedDate())
        .modelContainer(previewContainer)
//       .preferredColorScheme(.dark) //프리뷰 다크모드
}
