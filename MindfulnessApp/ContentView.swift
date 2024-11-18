//
//  ContentView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 14/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var startingTab = "Home"
    var body: some View {
        TabView(selection: $startingTab) {
            SleepCalculatorView()
                .tabItem {
                    Image(systemName: "moon")
                }
                .tag("SleepCalculator")
            
            MeditationView()
                .tabItem {
                    Image(systemName: "leaf")
                }
                .tag("Meditation")
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag("Home")
            NotesView()
                .tabItem {
                    Image(systemName: "doc.plaintext")
                }
                .tag("Notes")
            
            SettingsView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                }
                .tag("Settings")
            
        }
    }
}

#Preview {
    ContentView()
}
