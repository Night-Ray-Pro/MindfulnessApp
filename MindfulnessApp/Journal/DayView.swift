import SwiftData
import SwiftUI

struct DayView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \JournalEntry.date, order: .reverse) var notes: [JournalEntry]
    
    @State private var filteredNotes: [JournalEntry] = []
    @State private var isFiltering: Bool = false
    var searchString: String
    
    var body: some View {
        VStack {
            if isFiltering {
                ProgressView("Filtering...") // Show a progress indicator while filtering
                    .padding()
            } else {
                LazyVStack {
                    ForEach(notes) { note in
                        NavigationLink(value: note) {
//                            Text("Hi")
                            TestView(note: note) // Replace with your desired view
                                .padding(.bottom, note.id == notes.last?.id ? 300 : 0)
                                .padding(.top, note.id == notes.first?.id ? 10 : 0)
                                .animation(.easeInOut, value: filteredNotes)
                        }
                    }
                }
            }
        }
        .onAppear {
            if !searchString.isEmpty{
                applyFiltering() // Filter initially when the view appears
            }else{
                filteredNotes = notes
            }
        }
        .onChange(of: searchString) {
            if !searchString.isEmpty{
                applyFiltering() // Filter initially when the view appears
            }else{
                filteredNotes = notes
            }
            // Re-filter whenever the search string changes
        }
    }
    
    /// Asynchronous filtering function
    private func applyFiltering() {
        isFiltering = true
        Task { @MainActor in
            let result = await performFiltering()
            filteredNotes = result
            isFiltering = false
        }
    }
    
    /// Perform filtering in a background thread
    private func performFiltering() async -> [JournalEntry] {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                let result: [JournalEntry]
                if searchString.isEmpty {
                    result = notes
                } else {
                    result = notes.filter { note in
                        note.title.localizedStandardContains(searchString) ||
                        note.content.localizedStandardContains(searchString) ||
                        (note.location?.localizedStandardContains(searchString) ?? false)
                    }
                }
                continuation.resume(returning: result)
            }
        }
    }

}

#Preview {
    DayView(searchString: "hihi")
}
