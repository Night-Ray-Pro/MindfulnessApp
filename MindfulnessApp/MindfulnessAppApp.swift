//
//  MindfulnessAppApp.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 14/11/24.
//

import SwiftData
import SwiftUI

@main
struct MindfulnessAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: JournalEntry.self)
    }
}
