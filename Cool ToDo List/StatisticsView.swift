//
//  StatisticsView.swift
//  Cool ToDo List
//
//  Created by Dávid Szuhay on 06/02/2024.
//

import SwiftUI

class statisticsViewModel {
    
    func getLetters() -> [String] {
        let calendar = Calendar.current
        let currentDate = Date()
        var startingLetters: [String] = []
        
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -6 + i, to: currentDate) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "E"
                let startingLetter = String(dateFormatter.string(from: date).prefix(1))
                startingLetters.append(startingLetter)
            }
        }
        return startingLetters
    }
}

struct StatisticsView: View {
    let totalTasks: Int
    let completedTasks: Int
    var lastWeekLetters: [String] = []
    let vm = statisticsViewModel()
    var tasksPerDay: [Int] = [13, 20, 10, 20, 25, 14, 18]
    @State var weeklyNote: String = ""
    
    init(totalTasks: Int, completedTasks: Int) {
        lastWeekLetters = vm.getLetters()
        self.totalTasks = totalTasks
        self.completedTasks = completedTasks
    }
    
    var body: some View {
        
        VStack(spacing: 40) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.7), radius: 10)
                .frame(width: 200, height: 100)
                .overlay(content: {
                    VStack {
                        Text("\"If you can't measure it, you can't improve it.\"")
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 2)
                        Text("- Lord Kelvin")
                    }
                })
                .padding(.top)
            
            VStack(spacing: 15) {
                Text("\(totalTasks) Tasks")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                HStack {
                    Text("\(completedTasks)")
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                    Text("Completed")
                    Text("/")
                    Text("\(totalTasks - completedTasks)")
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                    Text("Failed")
                }
                .font(.title2)
            }
            
            VStack {
                Rectangle()
                    .fill(.white)
                    .overlay(content: {
                        HStack(spacing: 25) {
                            ForEach(0..<7, id: \.self, content: { index in
                                Rectangle()
                                    .fill(.white)
                                    .overlay(content: {
                                        VStack {
                                            Text("\(tasksPerDay[index])")
                                            
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(.gray.opacity(0.2))
                                                .overlay(alignment: .bottom, content: {
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .fill(.blue)
                                                        .frame(height: CGFloat(tasksPerDay[index]*5))
                                                })
                                            
                                            Text("\(lastWeekLetters[index])")
                                        }
                                    })
                            })
                        }
                        .padding(.horizontal, 40)
                    })
                Rectangle()
                    .fill(.green.opacity(0))
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.gray.opacity(0.4))
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                            .overlay(content: {
                                ZStack(alignment: .top) {
                                    if weeklyNote.isEmpty {
                                        Text("Take a note of your week...")
                                            .font(.title3)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.top, 8)
                                            .padding(.leading, 6)
                                    }
                                    TextEditor(text: $weeklyNote)
                                        .scrollContentBackground(.hidden)
                                        .font(.title3)
                                }
                                .padding()
                            })
                            .padding()
                            .padding(.horizontal)
                    })
            }
           
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
        
       
        
    }
}

#Preview {
    StatisticsView(totalTasks: 120, completedTasks: 94)
}
