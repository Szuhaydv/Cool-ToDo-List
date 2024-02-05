//
//  ContentView.swift
//  Cool ToDo List
//
//  Created by Dávid Szuhay on 04/02/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            LoginView()
                .navigationTitle("Log In Page")
        }
    }
}

struct LoginView: View {
    var body: some View {
        NavigationLink(
            destination: MainMenuView(), label: {
                Text("Log In")
        })
    }
}

struct MainMenuView: View {
    var body: some View {
        TabView {
            Group {
                CalendarView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Calendar")
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    .background(.green)

                MainTaskView()
                    .tabItem {
                        Image(systemName: "figure.martial.arts")
                        Text("Main Tasks")
                    }
                
                StatisticsView()
                    .tabItem {
                        Image(systemName: "chart.bar.fill")
                        Text("Statistics")
                    }
            }
            .toolbarBackground(.black, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

struct CalendarView: View {
    
    let daysOfWeek: [String] = ["M", "T", "W", "T", "F", "S", "S"]
    @State var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                }
                .frame(maxWidth: .infinity)
                .font(.headline)
                .fontWeight(.bold)
            }
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .tint(.red)
                
        }
    }
}

struct MainTaskView: View {
    var body: some View {
        Text("Main Tasks View")
            .navigationTitle("Tasks")
    }
}

struct StatisticsView: View {
    var body: some View {
        Text("Statistics View")
            .navigationTitle("Statistics")
    }
}


#Preview {
    ContentView()
}
