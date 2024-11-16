//
//  SettingsView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Text("Settings")
            }
            .toolbarBackground(Color("Settings"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    SettingsView()
}
