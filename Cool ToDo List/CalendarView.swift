//
//  CalendarView.swift
//  Cool ToDo List
//
//  Created by Dávid Szuhay on 06/02/2024.
//

import SwiftUI
import FSCalendar

struct CalendarView: View {
    
    let daysOfWeek: [String] = ["M", "T", "W", "T", "F", "S", "S"]
    @State var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            CalendarViewRepresentable(selectedDate: $selectedDate)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.3)
            
            HStack(spacing: 25) {
                CustomFilter(title: "HOME / WORK", content: "Work")
                
                CustomFilter(title: "TYPE")
                
                CustomFilter(title: "PRIORITY")
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

#Preview {
    CalendarView()
}
