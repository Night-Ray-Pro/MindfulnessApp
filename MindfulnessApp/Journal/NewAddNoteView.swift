//
//  NewAddNoteView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 28/11/24.
//

import SwiftUI
import PhotosUI

struct NewAddNoteView: View {
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
                        Image(.journalAddNewLookVector)
                            .resizable()
                            .ignoresSafeArea()
                        
                        ScrollView {
                            
                            ZStack{
                                //Content
                                VStack{
                                    
                                    HStack{
                                        
                                        TextField("Title...", text: $title, axis:.vertical)
                                            .padding(.bottom, isThePhotoBoxShowing ? 0 : 20)
                                            .frame(minHeight: 160, alignment: isThePhotoBoxShowing ? .center : .bottom)
                                        //                                    .background(.blue)
                                            .focused($isFocused)
                                            .multilineTextAlignment(.center)
                                            .foregroundStyle(.white)
                                            .padding(10)
                                            .background(.red.opacity(0.0))
                                            .font(.system(size: isThePhotoBoxShowing ? 30 : 40, weight: .semibold, design: .rounded))
                                            .onChange(of: title, {
                                                guard let newValueLastChar = title.last else { return }
                                                if newValueLastChar == "\n" {
                                                    title.removeLast()
                                                    isFocusedContent = true
                                                }
                                            })
                                        
                                        // Photos tab view
                                        if isThePhotoBoxShowing{
                                            TabView{
                                                ForEach(imageData, id: \.self){ imageResource in
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
                                    .onChange(of: imageData){
                                        withAnimation(.easeInOut(duration: 0.4)){
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
                                    
                                    Image(.textSeparatorJournalAddView)
                                        .padding(.top, -10)
                                    
                                    // Date and location Text
                                    HStack{
                                        Text(Date.now.formatted(date: .abbreviated, time: .omitted))
                                            .foregroundStyle(.white)
                                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                                        
                                        Spacer()
                                        
                                        Text(location)
                                            .animation(.easeInOut, value: location)
                                            .foregroundStyle(.white)
                                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    }
                                    .frame(width: 322)
                                    
                                    NewTextEditorView(string: $content)
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
                    OnlinePhotosView(choosenImages: $imageData)
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
    }
}

#Preview {
    NewAddNoteView()
}
