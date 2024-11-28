//
//  TestView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 22/11/24.
//

import SwiftUI
import _SwiftData_SwiftUI

struct TestView: View {
    @Bindable var note: JournalEntry
    var body: some View {
        Text("Test")
//        MapView(locationName: $note.location)
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: JournalEntry.self, configurations: config)
        let note = JournalEntry()
        return TestView(note: note)
            .modelContainer(container)
    }catch{
        return Text("Cant start the canvas")
    }
    
}
