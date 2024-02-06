//
//  ContentView.swift
//  Cool ToDo List
//
//  Created by Dávid Szuhay on 04/02/2024.
//

import SwiftUI
import UIKit

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

#Preview {
    LoginView()
}
