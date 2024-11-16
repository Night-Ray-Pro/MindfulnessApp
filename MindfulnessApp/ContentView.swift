//
//  ContentView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 14/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SleepCalculatorView()
                .tabItem {
                    Image(systemName: "moon")
                }
            
            MeditationView()
                .tabItem {
                    Image(systemName: "leaf")
                }
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            
            NotesView()
                .tabItem {
                    Image(systemName: "pencil.and.scribble")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
