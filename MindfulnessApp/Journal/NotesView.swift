//
//  NotesView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftData
import SwiftUI

struct NotesView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \JournalEntry.date, order: .reverse) var notes: [JournalEntry]
    let buttonOverlayColor = Color(red: 177 / 255, green: 147 / 255, blue: 233 / 255)
    @State private var tabbarVisibility = Visibility.visible
    @State private var opacity = 1.0
    @State private var isScrolling = false
    @State private var isSearching = false
    @State private var searchString = String()
    @State private var sortOrder = 0
    @State private var path = [JournalEntry]()
    @FocusState private var isFocused: Bool
    let sortButtons = ["Day", "Month", "Year"]
    
    var body: some View {
        NavigationStack(path: $path){
            ZStack{
                Image(.journalVector)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                VStack{
                    ScrollViewReader { value in
                    HStack{
                        
                        Button{
                            let newNote = JournalEntry()
                            modelContext.insert(newNote)
                            path = [newNote]
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
                            LazyVStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 35)
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
                                                ForEach(0..<3){ num in
                                                    Button{
                                                        withAnimation(.snappy(duration: 0.4, extraBounce:0.01)){
                                                            sortOrder = num
                                                        }
                                                    }label: {
                                                        Text(sortButtons[num])
                                                            .frame(width:100, height:45)
                                                        
                                                    }
                                                    num == 2 ? nil:Spacer()
                                                }
                                                
                                            }
                                            HStack{
                                                sortOrder == 0 ? nil:Spacer()
                                                RoundedRectangle(cornerRadius: 33)
                                                    .stroke(buttonOverlayColor, lineWidth: 2)
                                                    .frame(width:100, height:45)
                                                sortOrder == 2 ? nil:Spacer()
                                            }
                                            
                                        }
                                        .padding(.horizontal,2)
                                        .foregroundStyle(.white)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        
                                    }
                                    
                                }
                                .frame(width: 352, height: 50)
                                
                                
                                
                                ForEach(notes){note in
                                    NavigationLink(value: note){

                                        // DayView
                                        DisplayEntryView(note: note)
                                            .padding(.bottom, note.id == notes.last?.id ? 300 : 0)
                                            .padding(.top, note.id == notes.first?.id ? 10 : 0)
                                            .id(note.id)
                                        //MonthView
                                        //...code
                                        
                                        //YearView
                                        //...code
                                    }
                                }
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
                    
                    HStack{
                        Image(.leftFlowiJournal)
                            .offset(x:-35)
                        Spacer()
                        Image(.rightFlowiJournal)
                            .offset(x:12)
                    }
                    .offset(y:50)
                    .opacity(isScrolling ? 0:1)
                        
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
}

#Preview {
    NotesView()
}
