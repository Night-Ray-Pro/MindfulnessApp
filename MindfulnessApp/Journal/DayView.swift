//
//  DayView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 30/11/24.
//

//
//  NotesView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftData
import SwiftUI

struct DayView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \JournalEntry.date, order: .reverse) var notes: [JournalEntry]
    private var filteredNotes: [JournalEntry]{
        if searchString.isEmpty{
            return notes
        }else{
            
            return notes.filter{ $0.title.localizedStandardContains(searchString) ||
                $0.content.localizedStandardContains(searchString) ||
                $0.location?.localizedStandardContains(searchString) ?? false}
            
        }
    }
    var searchString: String
    
    var body: some View {
        LazyVStack{
            ForEach(filteredNotes){note in
                NavigationLink(value: note){
                    // DayView
                    DisplayEntryView(note: note)
                        .padding(.bottom, note.id == notes.last?.id ? 300 : 0)
                        .padding(.top, note.id == notes.first?.id ? 10 : 0)
                        .animation(.easeInOut, value: filteredNotes)
                    
                }
                
            }
            
        }
    }
}

#Preview {
    DayView(searchString: "hihi")
}

