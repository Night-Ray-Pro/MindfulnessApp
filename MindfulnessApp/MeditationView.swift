//
//  MeditationView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI

struct MeditationView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Text("Meditation")
            }
            .toolbarBackground(Color("Meditation"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    MeditationView()
}
