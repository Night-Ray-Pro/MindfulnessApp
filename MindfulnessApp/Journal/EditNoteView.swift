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
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
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
    @State private var titleText: String
    @State private var contentText: String
    @State private var isAlertShowing = false
    var currentDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: note.date)
    }
    var currentWeekInterval: String {
        guard let interval = Calendar.current.dateInterval(of: .weekOfMonth, for: note.date) else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        let startDate = formatter.string(from: interval.start)
        let endDate = formatter.string(from: interval.end)
        return "\(startDate) - \(endDate) \(Calendar.current.component(.year, from: note.date))"
    }
    
    init(note: JournalEntry) {
        self.note = note
        if note.photoData == nil || note.photoData?.isEmpty == true {
            isThePhotoBoxShowing = false
        } else{
            isThePhotoBoxShowing = true
        }
        self.titleText = note.title
        self.contentText = note.content
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .systemBlue
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
                                        
                                        TextField("Title...", text: $titleText, axis:.vertical)
                                            .padding(.bottom, isThePhotoBoxShowing ? 0 : 20)
                                            .frame(minHeight: 160, alignment: isThePhotoBoxShowing ? .center : .bottom)
                                        //                                    .background(.blue)
                                            .focused($isFocused)
                                            .multilineTextAlignment(.center)
                                            .foregroundStyle(.white)
                                            .padding(10)
                                            .background(.red.opacity(0.0))
                                            .font(.system(size: isThePhotoBoxShowing ? 30 : 40, weight: .semibold, design: .rounded))
                                            .onChange(of: titleText, {
                                                guard let newValueLastChar = titleText.last else { return }
                                                if newValueLastChar == "\n" {
                                                    titleText.removeLast()
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
                                    
                                    NewTextEditorView(string: $contentText)
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
                .alert("Delete note?", isPresented: $isAlertShowing){
                    Button("Cancel", role:.cancel){
                        //
                    }
                    
                    Button("Delete", role: .destructive){
                        updateEntryAmmount()
                        modelContext.delete(note)
                        dismiss()
                    }
                } message:{
                    Text("Are you sure you want to delete this note?")
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
                        isAlertShowing.toggle()
//                        updateEntryAmmount()
//                        modelContext.delete(note)
//                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.white)
                        
                    }
                }
            }
            
        }
        .onDisappear{
            note.title = titleText
            note.content = contentText
        }
        
    }
    
    func updateEntryAmmount(){

        if let week = weeks.first(where: { $0.week == currentWeekInterval }){
            print("Week exists")
            if let day = week.days.first(where: { $0.dayIdentyfier == currentDay }){
                print("Day exists")
                if day.entries > 0 {
                    day.entries -= 1
                    return
                }
            }
            print("Day not found")
            return
        }
        print("Week doesnt exist")
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
