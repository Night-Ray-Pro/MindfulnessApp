//
//  AddNoteView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 19/11/24.
//

import SwiftUI
import PhotosUI



struct AddNoteView: View {
    
    @State private var title = String()
    @State private var location = String()
    @State private var content = String()
    @State private var photo = [PhotosPickerItem]()
    @State private var imageData = [Data]()
    @FocusState private var isFocused: Bool
    @FocusState private var isFocusedContent: Bool
    @State private var sheetIsShowing: Bool = false
    @State private var browsePhotos: Bool = false
    @State private var isTryingToAddPhoto = false
    @State private var isPhotoPickerShowing = false
    @State private var isThePhotoBoxShowing = false
    
    var body: some View {
        ZStack{
            Group{
                ScrollViewReader { sp in
                    ZStack{
                        Rectangle()
                            .addNoteGradient()
                            .ignoresSafeArea()
                        
                        
                        ScrollView {
                            HStack{
                                VStack{
                                    
                                    Text(Date.now.formatted(date: .long, time: .omitted))
                                        .foregroundStyle(.white)
                                        .padding(.horizontal)
                                        .font(.system(size: 15, weight: .bold, design: .rounded))
                                    //                                    .background(.red)
                                    
                                    TextField("Title...", text: $title, axis:.vertical)
                                        .focused($isFocused)
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.white)
                                        .padding(10)
                                        .background(.red.opacity(0.0))
                                        .font(.system(size: 28, weight: .bold, design: .rounded))
                                        .onChange(of: title, {
                                            guard let newValueLastChar = title.last else { return }
                                            if newValueLastChar == "\n" {
                                                title.removeLast()
                                                isFocusedContent = true
                                            }
                                        })
                                    Button{
                                        sheetIsShowing.toggle()
                                    } label: {
                                        Text(location.isEmpty ? "Tap to add location": location)
                                            .foregroundStyle(location.isEmpty ? .black.opacity(0.2) : .white)
                                            .font(.system(size: 15, weight: .bold, design: .rounded))
                                        
                                    }
                                    
                                    
                                    Button{
                                        withAnimation{
                                            isTryingToAddPhoto.toggle()
                                        }
                                    } label: {
                                        Text("Browse photos")
                                            .foregroundStyle(location.isEmpty ? .black.opacity(0.2) : .white)
                                            .font(.system(size: 15, weight: .bold, design: .rounded))
                                            .padding()
                                        
                                    }
                                    
                                    
                                }
                                
                                
                                if isThePhotoBoxShowing{
                                    TabView{
                                        ForEach(imageData, id: \.self){ imageResource in
                                            if let uiimage = UIImage(data: imageResource){
                                                Image(uiImage: uiimage)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 150, height: 150)
                                                
                                            }
                                        }
                                        
                                    }
                                    //                                    frame(width: 150, height: 150)
                                    .tabViewStyle(.page)
                                    .frame(width: 150, height: 150)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                                    
                                }
                                
                                
                                
                                
                                
                            }
                            .onChange(of: imageData){
                                withAnimation{
                                    isThePhotoBoxShowing = true
                                }
                            }
                            .onChange(of: photo) {
                                
                                Task{
                                    imageData.removeAll()
                                    for item in photo{
                                        if let loadedImage = try? await item.loadTransferable(type: Data.self){
                                            withAnimation{
                                                self.imageData.append(loadedImage)
                                            }
                                        }
                                    }
                                    
                                }
                            }
                            .padding()
                            TextEditorView(string: $content)
                                .focused($isFocusedContent)
                                .scrollDisabled(true)
                            
                                .font(.title3)
                            //                        TextEditor(text: $content)
                                .foregroundStyle(.white)
                                .id("TextEditor")
                            //                            .focused($isFocused)
                                .scrollContentBackground(.hidden)
                                .frame(minHeight:400)
                                .padding()
                                .background(content: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(.ultraThinMaterial)
                                })
                                .padding(.horizontal)
                            
                            //                            .onChange(of: content) {
                            //                                sp.scrollTo("TextEditor", anchor: .bottom)
                            //                            }
                        }
                        .scrollDismissesKeyboard(.interactively)
                    }
                    
                }
                .confirmationDialog("Change background", isPresented: $isTryingToAddPhoto) {
                    Button("Online Library") { browsePhotos = true }
                    Button("Photo Library") { isPhotoPickerShowing = true }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Select a library")
                }
                .photosPicker(isPresented: $isPhotoPickerShowing, selection: $photo, matching: .images)
                .sheet(isPresented: $browsePhotos){
                                TestView(choosenImages: $imageData)
//                    ImageChoosingView()
                }
                .sheet(isPresented: $sheetIsShowing){
                    MapView(locationName: $location)
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isFocused = true
                    }
                }
                .preferredColorScheme(.light)
                .toolbar{
                    Button{
                        //
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.white)
                        
                    }
                }
                
            }
        }
//        .ignoresSafeArea()
        
    }
    
}

struct TextEditorView: View {
    
    @Binding var string: String
    @State var textEditorHeight : CGFloat = 20
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            Text(string)
                .foregroundColor(.clear)
                .padding(10)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewHeightKey.self,
                                           value: $0.frame(in: .local).size.height)
                })
            
            TextEditor(text: $string)
                .frame(height: max(400,textEditorHeight))
                .border(.clear)
            
            if string.isEmpty {
                
                Text("Content...")
                    .font(.title3)
                    .foregroundColor(.black.opacity(0.5))
                    .disabled(true)
                    .opacity(0.6)
                    .padding(.top, 8.5)
                    .padding(.leading, 5)
            }
            
        }
        .onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

#Preview {
    AddNoteView()
}
