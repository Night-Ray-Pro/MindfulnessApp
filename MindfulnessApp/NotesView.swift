//
//  NotesView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI

struct NotesView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Text("Notes")
            }
            .toolbarBackground(Color("Notes"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    NotesView()
}
