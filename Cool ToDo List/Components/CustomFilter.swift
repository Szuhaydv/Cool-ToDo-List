//
//  CustomFilter.swift
//  Cool ToDo List
//
//  Created by Dávid Szuhay on 06/02/2024.
//

import SwiftUI

struct CustomFilter: View {
    var title: String
    var content: String?
    @State var selectedOption: Int = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title.uppercased())
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

#Preview {
    CustomFilter(title: "Banana", content: "Work")
}
