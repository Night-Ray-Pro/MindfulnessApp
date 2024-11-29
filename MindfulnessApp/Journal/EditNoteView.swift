//
//  NewAddNoteView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 28/11/24.
//

import SwiftUI
import PhotosUI
import SwiftData

struct EditNoteView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Bindable var note: JournalEntry
    @State private var photo = [PhotosPickerItem]()
    @State private var imageData = [Data]()
    @FocusState private var isFocused: Bool
    @FocusState private var isFocusedContent: Bool
    @State private var sheetIsShowing: Bool = false
    @State private var browsePhotos: Bool = false
    @State private var isTryingToAddPhoto = false
    @State private var isPhotoPickerShowing = false
    @State private var isThePhotoBoxShowing:Bool
    
    init(note: JournalEntry) {
        self.note = note
        if note.photoData == nil || note.photoData?.isEmpty == true {
            isThePhotoBoxShowing = false
        } else{
            isThePhotoBoxShowing = true
        }
    }
    
    var body: some View {
        ZStack{
            Group{
                ScrollViewReader { sp in
                    ZStack{
                        Image(.journalAddNewLookVector)
                            .resizable()
                            .ignoresSafeArea()
                        
                        ScrollView {
                            
                            ZStack{
                                //Content
                                VStack{
                                    
                                    HStack{
                                        
                                        TextField("Title...", text: $note.title, axis:.vertical)
                                            .padding(.bottom, isThePhotoBoxShowing ? 0 : 20)
                                            .frame(minHeight: 160, alignment: isThePhotoBoxShowing ? .center : .bottom)
                                        //                                    .background(.blue)
                                            .focused($isFocused)
                                            .multilineTextAlignment(.center)
                                            .foregroundStyle(.white)
                                            .padding(10)
                                            .background(.red.opacity(0.0))
                                            .font(.system(size: isThePhotoBoxShowing ? 30 : 40, weight: .semibold, design: .rounded))
                                            .onChange(of: note.title, {
                                                guard let newValueLastChar = note.title.last else { return }
                                                if newValueLastChar == "\n" {
                                                    note.title.removeLast()
                                                    isFocusedContent = true
                                                }
                                            })
                                        
                                        // Photos tab view
                                        if isThePhotoBoxShowing{
                                            TabView{
                                                ForEach(note.photoData!, id: \.self){ imageResource in
                                                    if let uiimage = UIImage(data: imageResource){
                                                        Image(uiImage: uiimage)
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(width: 150, height: 160)
                                                            .clipShape(.rect(cornerRadius: 10))
                                                    }
                                                }
                                            }
                                            .tabViewStyle(.page)
                                            .frame(width: 150, height: 160)
                                            .clipShape(.rect(cornerRadius: 10))
                                            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                                            
                                        }
                                        
                                    }
                                    .frame(maxWidth: 343)
                                    //for animation reasons
                                    .onChange(of: note.photoData){
                                        withAnimation(.easeInOut(duration: 0.4)){
                                            isThePhotoBoxShowing = true
                                        }
                                    }
                                    .onChange(of: photo) {
                                        Task{
                                            if note.photoData == nil{
                                                note.photoData = [Data]()
                                            }
//                                            imageData.removeAll()
                                            for item in photo{
                                                if let loadedImage = try? await item.loadTransferable(type: Data.self){
                                                    withAnimation{
                                                        note.photoData!.append(loadedImage)
                                                    }
                                                }
                                            }
                                            photo.removeAll()
                                        }
                                    }
                                    
                                    Image(.textSeparatorJournalAddView)
                                        .padding(.top, -10)
                                    
                                    // Date and location Text
                                    HStack{
                                        Text(note.date.formatted(date: .abbreviated, time: .omitted))
                                            .foregroundStyle(.white)
                                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                                        
                                        Spacer()
                                        
                                        Text(note.location ?? "")
                                            .animation(.easeInOut, value: note.location)
                                            .foregroundStyle(.white)
                                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    }
                                    .frame(width: 322)
                                    
                                    NewTextEditorView(string: $note.content)
                                        .focused($isFocusedContent)
                                        .scrollDisabled(true)
                                        .font(.system(size: 15, weight: .medium, design: .rounded))
                                        .foregroundStyle(.white)
                                        .id("TextEditor")
                                        .scrollContentBackground(.hidden)
                                        .padding(10)
                                        .background{
                                            RoundedRectangle(cornerRadius: 20)
                                                .foregroundStyle(.ultraThinMaterial)
                                        }
                                        .padding(.bottom, 100)
                                    Spacer()
                                    //Photos and Location buttons
                                }
                                //bottom buttons
                                VStack{
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        VStack{
                                            Button{
                                                
                                                withAnimation{
                                                    isTryingToAddPhoto.toggle()
                                                }
                                            } label: {
                                                Text("Photos")
                                                    .foregroundStyle(.white)
                                                    .frame(width: 128, height: 40)
                                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                                    .background{
                                                        Rectangle()
                                                            .foregroundStyle(.ultraThinMaterial)
                                                    }
                                                    .clipShape(.capsule)
                                                
                                            }
                                            
                                            Button{
                                                sheetIsShowing.toggle()
                                            } label: {
                                                Text("Location")
                                                    .foregroundStyle(.white)
                                                    .frame(width: 128, height: 40)
                                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                                    .background{
                                                        Rectangle()
                                                            .foregroundStyle(.ultraThinMaterial)
                                                    }
                                                    .clipShape(.capsule)
                                                
                                            }
                                        }
                                    }
                                    .frame(width:343)
                                }
                            }
                            .frame(minHeight: 725)
                        }
                        .scrollDismissesKeyboard(.interactively)
                        .scrollIndicators(.hidden)
//                        .scrollBounceBehavior(.basedOnSize)
                    }
                    
                }
                .confirmationDialog("Change background", isPresented: $isTryingToAddPhoto) {
                    Button("Online Library") { browsePhotos = true }
                    Button("Photo Library") { isPhotoPickerShowing = true }
                    Button("Cancel", role: .cancel) { }
                }
                .photosPicker(isPresented: $isPhotoPickerShowing, selection: $photo, matching: .images)
                .sheet(isPresented: $browsePhotos){
                    OnlinePhotosView(choosenImages: $note.photoData)
                }
                .sheet(isPresented: $sheetIsShowing){
                    MapView(locationName: $note.location, latitude: $note.latitude, longitude: $note.longitude)
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if note.title.isEmpty{
                            isFocused = true
                        }
                    }
                }
                .preferredColorScheme(.light)
                .toolbar{
                    Button{
                        modelContext.delete(note)
                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.white)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: JournalEntry.self, configurations: config)
        let note = JournalEntry()
        return EditNoteView(note: note)
            .modelContainer(container)
    }catch{
        return Text("Cant start the canvas")
    }
    
}