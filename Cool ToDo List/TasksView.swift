//
//  TasksView.swift
//  Cool ToDo List
//
//  Created by Dávid Szuhay on 06/02/2024.
//

import SwiftUI

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
            Color.gray.opacity(0.5)
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.13)
            VStack {
                HStack {
                    Image(systemName: "calendar")
                        .padding(.top, 10)
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
                                }.opacity(0)
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
                                }.opacity(0)
                            }
                        }
                    }
                }
                .font(.title)
                .padding(.all, 0)
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
            
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
                    .padding(.top)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: UIScreen.main.bounds.height * 0.14)
//                .background(.blue)
                .overlay(alignment: .top, content: {
                    VStack {
                        // FIX: Disappears only a second or so after letting go
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
                            .padding(.top, -4)
                        
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
                
                HStack {
                    Text("Top Three Tasks")
                        .font(.largeTitle)
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 24))
                }
                
                HStack {
                    VStack {
                        Text("Progress")
                        ZStack {
                            Text("75")
                            Circle()
                                .stroke(
                                    .white,
                                    lineWidth: 7
                                )
                                .frame(width: 60, height: 60)
                            Circle()
                                .trim(from: 0, to: 0.75)
                                .stroke(
                                    .blue,
                                    style: StrokeStyle(
                                        lineWidth: 5,
                                        lineCap: .round
                                    )
                                )
                                .rotationEffect(.degrees(-90))
                                .frame(width: 60, height: 60)
                        }
                        
                    }
                    VStack (spacing: 15) {
                        Text("Quote of the day:")
                            .font(.headline)
                        Text("If you can't measure it, you can't improve it.")
                            .multilineTextAlignment(.center)
                            .italic()
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .frame(maxWidth: .infinity, alignment: .top)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding(.leading, 50)
                .padding(.top, 2)
                
                VStack(spacing: 16) {
                    CustomTaskLong(isCompleted: true, taskTitle: "Play the lute", taskSubtitle: "Such a beautiful melody...")
                    
                    CustomTaskLong(isCompleted: true, taskTitle: "Slay the dragon", taskSubtitle: "What a mighty beast!")
                    
                    CustomTaskLong(isCompleted: false, taskTitle: "Save the princess!", taskSubtitle: "Most beautiful in the 7 kingdoms")
                }
                .padding(.top)
                
                Spacer()
                
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        }
    }
}

#Preview {
    NavigationStack {
        MainTaskView()
            .navigationTitle("Tasks")
    }
}
