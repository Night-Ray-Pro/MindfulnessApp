//
//  NotesView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftData
import SwiftUI

struct NewNotesView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \JournalEntry.date, order: .reverse) var notes: [JournalEntry]
    let buttonOverlayColor = Color(red: 177 / 255, green: 147 / 255, blue: 233 / 255)
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
    @State private var currentWorkItem: DispatchWorkItem?
    @State private var isForEachVisible = true
    @State private var tabbarVisibility = Visibility.visible
    @State private var opacity = 1.0
    @State private var isScrolling = false
    @State private var isSearching = false
    @State private var searchString = String()
    @State private var newNoteTrackHaptics: Bool = false
    @State private var sortOrder = sortViews.Day
    @State private var path = [JournalEntry]()
    @FocusState private var isFocused: Bool
    @AppStorage("haptics") var haptics = false
    var filteredNotes: [JournalEntry] {
            if searchString.isEmpty {
                return notes
            } else {
                return notes.filter { $0.title.localizedStandardContains(searchString) ||
                    $0.content.localizedStandardContains(searchString) ||
                    $0.location?.localizedStandardContains(searchString) ?? false}
            }
        }
    enum sortViews: CaseIterable {
        case Day, Month, Year
    }
    let sortButtons = ["Day", "Month", "Year"]
    
    var body: some View {
        NavigationStack(path: $path){
            ZStack{
                Image(.journalVector)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                VStack{
                    Spacer()
                    
                    HStack{
                        Image(.leftFlowiJournal)
                            .offset(x:-35)
                        Spacer()
                        Image(.rightFlowiJournal)
                            .offset(x:12)
                    }
                    .offset(y:50)
            
                        
                }
                .ignoresSafeArea()
                .opacity(opacity)
                .animation(.easeInOut(duration:opacity == 1.0 ? 0.5:0.01).delay(0.3), value: opacity)
                
                VStack{
                    ScrollViewReader { value in
                    HStack{
                        
                        Button{
                            if let week = weeks.first{
                                week.days.last!.entries += 1

                            }
                            newNoteTrackHaptics.toggle()
                            let newNote = JournalEntry()
                            modelContext.insert(newNote)
                            path = [newNote]
                            print(notes.count)
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.white)
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            withAnimation{
                                if isSearching == true{
                                    isFocused = false
                                    searchString = ""
                                }else {
                                    isFocused = true
                                }
                                searchString = String()
                                isSearching.toggle()
                                
                            }
                            
                            print(isFocused)
                        } label: {
                            
                            if isSearching == true{
                                Image(systemName: "line.3.horizontal.decrease.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.white)
                                
                            }else{
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.white)
                            }
//
                        }
                        
                    }
                    .padding(.top, 55)
//                    .padding(.bottom, 5)
                    .padding(.horizontal,20)
                    Text("Oskar's Journal")
                        .font(.custom("SignPainter", size: 60))
                        .foregroundStyle(.white)
//                        .padding(.top,-5)

                    
                    Text("I’m creating the life of my dreams.")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.top, -5)
                        .padding(.bottom, 15)
                        
                    
                    
                    
                        
                        Button{
                            withAnimation{
                                value.scrollTo(0)
                            }
                        } label: {
                            Image(.journalVector3)
                        }
                        
                        Spacer()
                        ScrollView{
                            VStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 35)
                                        .frame(width:352)
                                        .foregroundStyle(.ultraThinMaterial)
                                        .id(0)
                                        .preferredColorScheme(.light)
                                    
                                    
                                    if isSearching{
                                        //filter buttons
                                        TextField("Search", text: $searchString)
                                            .focused($isFocused)
                                            .padding(.horizontal,10)
                                            .foregroundStyle(.white)
                                            .font(.system(size: 16, weight: .medium, design: .rounded))
                                    }else{
                                        ZStack{
                                            HStack{
                                                ForEach(sortViews.allCases, id: \.self){ num in
                                                    Button{
                                                        withAnimation(.smooth(duration: 0.25)){
                                                            sortOrder = num
                                                            handleButtonPress()
                                                        }
                                                    }label: {
                                                        Text(String(describing: num))
                                                            .frame(width:100, height:45)
                                                        
                                                    }
                                                    num == .Year ? nil:Spacer()
                                                }
                                                
                                            }
                                            .frame(width:352)
                                            
                                            HStack{
                                                
                                                RoundedRectangle(cornerRadius: 33)
                                                    .stroke(buttonOverlayColor, lineWidth: 2)
                                                    .frame(width:100, height:45)
                                                    .offset(x: sortOrder == .Day ? -124:0)
                                                    .offset(x: sortOrder == .Year ? 124:0)
                                                
                                            }
                                            
                                        }
                                        .padding(.horizontal,2)
                                        .foregroundStyle(.white)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        
                                    }
                                    
                                }
                                .frame(width:352, height:50)
                            }
                            .frame(maxWidth: .infinity)
//                            .background(.red)
                                
                                
//                                ForEach(1..<5){ num in
//                                    Text("Hi")
//                                        .id(num)
//                                }
                            
//                                DayView(searchString: searchString)
                            if !isFocused && isForEachVisible{
//                                DayView(searchString: searchString)
//                                    .transition(.opacity)
                                Group{
                                    switch sortOrder {
                                    case .Day:
                                        DayView(searchString: searchString)
//                                            .transition(.opacity)
                                    case .Month:
                                        MonthView(searchString: searchString)
//                                            .transition(.opacity)
                                    case .Year:
//                                        Text("Year")
                                        YearView(searchString: searchString/*, notes: notes*/)
                                            
                                    }
                                }
                                .transition(.opacity)
                                .animation(.easeInOut, value: isForEachVisible)
                               
                               
                               
                            }else{
                                
                                Text("")
//                                ForEach(filteredNotes) { note in
//                                    NavigationLink(value: note) {
//                                        //                            Text("Hi")
//                                        TestView(note: note) // Replace with your desired view
//                                            .padding(.bottom, note.id == notes.last?.id ? 300 : 0)
//                                            .padding(.top, note.id == notes.first?.id ? 10 : 0)
//                                            .animation(.easeInOut, value: notes)
//                                    }
//                                }
                            }
                           
                            
                                
                            

                        }
                        
                        .scrollDismissesKeyboard(.immediately)
                        .opacity(opacity)
                        .animation(.easeInOut(duration:opacity == 1.0 ? 0.5:0.01).delay(0.3), value: opacity)
                        .scrollIndicators(.hidden)
                        .onScrollPhaseChange { oldPhase, newPhase in
                            withAnimation(.easeInOut(duration: 0.5).delay(isScrolling ? 2:0)) {
                                isScrolling = newPhase.isScrolling
                            }
                        }
                        
                    }
                }
                .ignoresSafeArea()
//                .padding(.top,25)
                
                VStack{
                    Spacer()
                    
                
                        
                }
                .opacity(opacity)
                .animation(.easeInOut(duration:opacity == 1.0 ? 0.5:0.01).delay(0.3), value: opacity)
                .ignoresSafeArea()
            }
            .navigationDestination(for: JournalEntry.self){ entry in
                EditNoteView(note: entry)
                    .toolbarBackground(Color(red: 146 / 255, green: 128 / 255, blue: 193 / 255), for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                
                    .onAppear {
                        tabbarVisibility = .hidden
                        opacity = 0.0
                    }
                    .onDisappear{
                        tabbarVisibility = .visible
                        opacity = 1.0
                    }
            
            }
            .toolbarBackground(Color("Notes"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
            
        }
        .sensoryFeedback(haptics ? .selection : .alignment, trigger: sortOrder)
        .sensoryFeedback(haptics ? .selection : .alignment, trigger: isSearching)
        .sensoryFeedback(haptics ? .selection : .alignment, trigger: newNoteTrackHaptics)
        .onAppear{
            do{
                try modelContext.save()
            }catch{
                print("cant save")
            }
        }
        .toolbar(tabbarVisibility, for: .tabBar)
        .animation(.easeInOut(duration:0.2), value: tabbarVisibility)
        .accentColor(.white)
    }
    
    private func handleButtonPress() {
           // Cancel any ongoing work
           currentWorkItem?.cancel()

           // Hide the ForEach
           withAnimation {
               isForEachVisible = false
           }

           // Create a new DispatchWorkItem
           let workItem = DispatchWorkItem {
               // Update content
//               updateContent()

               // Show the ForEach again after a delay
               DispatchQueue.main.async {
                   withAnimation {
                       isForEachVisible = true
                   }
               }
           }

           // Assign the new work item to the state variable
           currentWorkItem = workItem

           // Execute the work item after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: workItem)
       }
}

#Preview {
    NewNotesView()
}
