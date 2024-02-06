//
//  MainMenuView.swift
//  Cool ToDo List
//
//  Created by Dávid Szuhay on 06/02/2024.
//

import SwiftUI

struct MainMenuView: View {
    @State var selectedPage: Int = 2
    @State var selectedDate: Date = Date()
    
    var body: some View {
        TabView (selection: $selectedPage){
            Group {
                CalendarView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    .tag(1)

                MainTaskView()
                    .tabItem {
                        Image(systemName: "figure.martial.arts")
                        Text("Main Tasks")
                    }
                    .tag(2)
                
                StatisticsView(totalTasks: 120, completedTasks: 94)
                    .tabItem {
                        Image(systemName: "chart.bar.fill")
                        Text("Statistics")
                            .navigationTitle("Statistics")
                    }
                    .navigationTitle("Statistics")
                    .tag(3)
                    
            }
            .toolbarBackground(.black, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
            .navigationTitle("Statistics")
        }
        .navigationTitle(selectedPage == 1 ? "Calendar" : selectedPage == 2 ? "Tasks" : "Statistics")
    }
}

#Preview {
    MainMenuView()
}
