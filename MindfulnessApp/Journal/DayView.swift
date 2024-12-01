import SwiftData
import SwiftUI

struct DayView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [JournalEntry]
    
    init(searchString: String) {
        let predicate =  #Predicate<JournalEntry> { note in
            note.title.localizedStandardContains(searchString) ||
            note.content.localizedStandardContains(searchString) ||
            note.location?.localizedStandardContains(searchString) ?? false
        }
        if searchString.isEmpty{
            _notes = Query(sort: [SortDescriptor(\JournalEntry.date, order: .reverse)])
        }else{
            _notes = Query(filter: predicate, sort: [SortDescriptor(\JournalEntry.date, order: .reverse)])
        }
    }
    
    var body: some View {
        ForEach(notes) { note in
            NavigationLink(value: note) {
                //                            Text("Hi")
                OptymizedDisplayEntryView(note: note) // desired view
                    .padding(.bottom, note.id == notes.last?.id ? 300 : 0)
                    .padding(.top, note.id == notes.first?.id ? 10 : 0)
                    .animation(.easeInOut, value: notes)
            }
        }
        
    }
    
  

}

#Preview {
    DayView(searchString: "hihi")
}
