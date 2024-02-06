//
//  CustomTaskLong.swift
//  Cool ToDo List
//
//  Created by Dávid Szuhay on 06/02/2024.
//

import SwiftUI

struct CustomTaskLong: View {
    
    var isCompleted: Bool
    var taskTitle: String
    var taskSubtitle: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .stroke(.black, lineWidth: 1)
            .overlay(content: {
                HStack() {
                    Image(systemName: isCompleted ? "checkmark.square" : "square")
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text(taskTitle)
                            .fontWeight(.semibold)
                        Text(taskSubtitle)
                            .fontWeight(.light)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            })
            .frame(height: 50)
            .padding(.horizontal, 32)
    }
}

#Preview {
    CustomTaskLong(isCompleted: false, taskTitle: "Play the lute", taskSubtitle: "What a beautiful melody")
}
