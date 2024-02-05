//
//  ContentView.swift
//  Cool ToDo List
//
//  Created by Dávid Szuhay on 04/02/2024.
//

import SwiftUI
import UIKit
import FSCalendar

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
                
                StatisticsView()
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

struct CalendarView: View {
    
    let daysOfWeek: [String] = ["M", "T", "W", "T", "F", "S", "S"]
    @State var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            CalendarViewRepresentable(selectedDate: $selectedDate)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.3)
            HStack(spacing: 25) {
                
                CustomRoundedRectangle(title: "HOME / WORK", content: "Work")
                
                CustomRoundedRectangle(title: "TYPE")
                
                CustomRoundedRectangle(title: "PRIORITY")
                
            }
            .frame(maxWidth: .infinity)
//            .background(.green)
            ScrollView {
                HStack {
                    ZStack {
                        Path { path in
                            path.move(to: CGPoint(x: UIScreen.main.bounds.width * 0.10, y: 5))
                            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width * 0.10, y: 5 + 16 * 30))
                        }
                        .stroke(Color.black, lineWidth: 2)

                        ForEach(0..<17) { index in
                            Path { path in
                                path.move(to: CGPoint(x: UIScreen.main.bounds.width * 0.125, y: 5 + CGFloat(index) * 30))
                                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width * 0.075, y: 5 + CGFloat(index) * 30))
                            }
                            .stroke(Color.black, lineWidth: 2)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.15, height: 16 * 30 + 10)
//                    .background(Color.red)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//                .background(Color.yellow)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            
                
        }
        .navigationTitle("Statistics")
    }
}

struct CustomRoundedRectangle: View {
    var title: String
    var content: String?
    @State var selectedOption: Int = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 10))
                .padding(.leading, 5)
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 1)
                .fill(.white)
                .shadow(color: Color.black.opacity(0.25), radius: 5, x: 0, y: 5)
                .frame(width: UIScreen.main.bounds.width * 0.25, height: 44)
                .overlay(content: {
                    Menu(content ?? "—", content: {
                        Picker("Options", selection: $selectedOption) {
                            Button(action: {
                                print("Menu button 2")
                            }) {
                                Label("Work", systemImage: "suitcase.fill")
                            }
                            Button(action: {
                                print("Menu button 3")
                            }) {
                                Label("Personal", systemImage: "person.fill")
                            }
                        }
                    })
                })
        }
    }
}


struct CalendarViewRepresentable: UIViewRepresentable {
    
    @Binding var selectedDate: Date
    var manyTasks: [Int] = [13, 14, 28, 1, 22]
    var mediumTasks: [Int] = [4, 9, 12, 16, 21]
    var fewTasks: [Int] = [2,3,7,25,27,30]
    
    typealias UIViewType = FSCalendar
    

    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.headerHeight = 0.0
        calendar.scrollEnabled = false
        calendar.placeholderType = .none
        calendar.delegate = context.coordinator
        calendar.appearance.titleFont = .systemFont(ofSize: 20, weight: .thin)
        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, FSCalendarDelegateAppearance,
          FSCalendarDelegate, FSCalendarDataSource {
        var parent: CalendarViewRepresentable

        init(_ parent: CalendarViewRepresentable) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            let dayOfMonth = Calendar.current.component(.day, from: date)
            if parent.manyTasks.contains(dayOfMonth) {
                return .red
            } else if parent.mediumTasks.contains(dayOfMonth) {
                return .blue
            } else if parent.fewTasks.contains(dayOfMonth) {
                return .green
            } else {
                return nil
            }
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
