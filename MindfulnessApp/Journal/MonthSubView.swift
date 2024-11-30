//
//  MonthSubView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 30/11/24.
//

import SwiftUI
import SwiftData

struct MonthSubView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [JournalEntry]
    init(searchString: String, selectedMonth: Int) {
        
        let predicateMonth =  #Predicate<JournalEntry> { note in
            note.month == selectedMonth
        }
        
        let predicateSearch =  #Predicate<JournalEntry> { note in
            note.month == selectedMonth && (
            note.title.localizedStandardContains(searchString) ||
            note.content.localizedStandardContains(searchString) ||
            note.location?.localizedStandardContains(searchString) ?? false
            )
        }
        if searchString.isEmpty{
            _notes = Query(filter: predicateMonth, sort: [SortDescriptor(\JournalEntry.date, order: .reverse)])
        }else{
            _notes = Query(filter: predicateSearch, sort: [SortDescriptor(\JournalEntry.date, order: .reverse)])
        }
        
    }
    
    var body: some View {
        ForEach(notes) { note in
            NavigationLink(value: note) {
                //                            Text("Hi")
                TestView(note: note) // Replace with your desired view
                    .padding(.bottom, note.id == notes.last?.id ? 300 : 0)
                    .padding(.top, note.id == notes.first?.id ? 10 : 0)
                    .animation(.easeInOut, value: notes)
            }
        }
    }
}

#Preview {
    MonthSubView(searchString: "Hihi", selectedMonth: 0)
}
