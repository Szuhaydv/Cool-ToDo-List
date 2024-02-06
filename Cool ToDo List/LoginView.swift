//
//  ContentView.swift
//  Cool ToDo List
//
//  Created by Dávid Szuhay on 04/02/2024.
//

import SwiftUI
import UIKit
import FSCalendar
import Foundation

struct LoginView: View {
    var body: some View {
        NavigationStack {
            NavigationLink(
                destination: MainMenuView(), label: {
                    Text("Log In")
            })
        }
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

class dayFunctions {
    
    func daysOfCurrentMonth() -> [Int]? {
        // Get the current calendar and current date
        let calendar = Calendar.current
        let currentDate = Date()

        // Create a date for the first day of the current month
        if let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate)) {
            // Get the range of days for the current month
            if let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) {
                // Create an array of days
                return Array(1...range.count)
            }
        }

        print("Failed to get the range of days for the current month.")
        return nil
    }
    
    func dayAbbreviation(difference: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let dayAbbreviation: String
        
        if let dayInQuestion = Calendar.current.date(byAdding: .day, value: difference, to: Date()) {
            dayAbbreviation = dateFormatter.string(from: dayInQuestion)
            return dayAbbreviation
        }
        return nil
    }
}

struct MainTaskView: View {
    
    let vm = dayFunctions()
    let daysArray: [Int]
    let dayOfMonth: Int
    @State var showInfo1 = false
    
    init() {
        self.daysArray = vm.daysOfCurrentMonth() ?? []
        
        let calendar = Calendar.current
        let currentDate = Date()
        dayOfMonth = calendar.component(.day, from: currentDate)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.gray
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.15)
            VStack {
                HStack {
                    Image(systemName: "calendar")
                    Text("May, 2022")
                        .font(.subheadline)
                }
                
                HStack(spacing: 0) {
                    ZStack {
                        if !daysArray.isEmpty {
                            ForEach(daysArray.prefix(dayOfMonth), id: \.self) {day in
                                VStack {
                                    Text("\(day)")
                                    Text("\(vm.dayAbbreviation(difference: day - dayOfMonth) ?? "")")
                                        .font(.headline)
                                }
                            }
                        }
                    }
                    VStack {
                        Text("\(dayOfMonth-2)")
                        Text("\(vm.dayAbbreviation(difference: -2) ?? "")")
                            .font(.headline)
                    }
                    Spacer()
                    VStack {
                        Text("\(dayOfMonth-1)")
                        Text("\(vm.dayAbbreviation(difference: -1) ?? "")")
                            .font(.headline)
                    }
                    Spacer()
                    VStack {
                        Text("\(dayOfMonth)")
                            .fontWeight(.semibold)
                            .scaleEffect(1.75)
                        Text("\(vm.dayAbbreviation(difference: 0) ?? "")")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    VStack {
                        Text("\(dayOfMonth+1)")
                        Text("\(vm.dayAbbreviation(difference: 1) ?? "")")
                            .font(.headline)
                    }
                    Spacer()
                    VStack {
                        Text("\(dayOfMonth+2)")
                        Text("\(vm.dayAbbreviation(difference: +2) ?? "")")
                            .font(.headline)
                    }
                    ZStack {
                        if !daysArray.isEmpty {
                            ForEach(daysArray.suffix(from: dayOfMonth + 2), id: \.self) {day in
                                VStack {
                                    Text("\(day)")
                                    Text("\(vm.dayAbbreviation(difference: day - dayOfMonth) ?? "")")
                                        .font(.headline)
                                }
                            }
                        }
                    }
                }
                .font(.title)
                .padding(.all, 0)
                .padding(.top, 30)
                .frame(maxWidth: .infinity)
                .background(.yellow)
            
                ScrollView(.horizontal) {
                    HStack(spacing: 15) {
                        ForEach(0..<10) { index in
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.black, lineWidth: 2)
                                .fill(.white)
                                .shadow(color: .black.opacity(0.4), radius: 5, x: 5, y: 5)
                                .frame(width: 140, height: 80)
                                .overlay(content: {
                                    Text("Task #\(index + 1)")
                                })
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: UIScreen.main.bounds.height * 0.175)
//                .background(.blue)
                .overlay(alignment: .top, content: {
                    VStack {
                        Image(systemName: "info.circle.fill")
                            .font(.system(size: 24))
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                        .onChanged({ _ in
                                            withAnimation{
                                                showInfo1 = true
                                            }
                                        })
                                        .onEnded({ _ in
                                            withAnimation {
                                                showInfo1 = false
                                            }
                                        })
                            )
                            .padding(.trailing, 20)
                            .padding(.top, -10)
                        
                        if showInfo1 {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.red)
                                .frame(width: 200, height: 100)
                                .overlay(content: {
                                    Text("Tasks assigned for today, without a specified time")
                                        .multilineTextAlignment(.center)
                                        .padding()
                                })
                                .frame(width: UIScreen.main.bounds.width, alignment: .trailing)
                                
                                .padding(.trailing, 40)
                        }
                            
                    }
                    
                })
                
                Spacer()
                
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        }
        .background(.green)
    }
}

struct StatisticsView: View {
    var body: some View {
        Text("Statistics View")
    }
}


#Preview {
    NavigationStack {
        MainTaskView()
            .navigationTitle("Tasks")
    }
    
}
