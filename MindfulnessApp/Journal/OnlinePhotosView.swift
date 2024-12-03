//
//  TestView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 22/11/24.
//

import SwiftUI

struct Results : Codable{
    var total : Int
    var totalHits : Int
    var hits : [Hit]
}

struct Hit : Codable{
    var id : Int
    var previewURL : String
    var webformatWidth : Int
    var webformatHeight : Int
    var largeImageURL : String
}

struct OnlinePhotosView: View {
    @FocusState private var isFocused: Bool
    @Binding var choosenImages : [Data]?
    @State private var isSelected = [Int]()
    @State private var photosURL = [String]()
    @State private var number = 1
    @State private var testBool = true
    let testString = "hello"
    @State private var selectedButton: Int? = 1
    @State private var pulsate = false
    @State private var results: Results?
    @State private var searchPrompt = String()
    @Environment(\.dismiss) var dismiss
    
//    init(choosenImages: [Data]?) {
//        self.choosenImages = choosenImages
//        if self.choosenImages == nil{
//            self.choosenImages = [Data]()
//        }
//    }
    var body: some View {
        NavigationStack{
            VStack{
                TextField("\(Image(systemName: "magnifyingglass"))  Search online library...", text: $searchPrompt)
                    .textFieldStyle(.plain)
                    .focused($isFocused)
                    .onChange(of: searchPrompt, { oldValue, newValue in
                        Task{
                            await loadData()
                        }
                    })
                    .padding(.horizontal, 8)
                    .padding(.vertical, 7.5)
                    .background(Color.gray.opacity(0.25).cornerRadius(10))
                    .font(.system(size: 17, weight: .regular))
                //                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                    .padding(.horizontal,18)
                
            }
            //            .background(.red)
            ScrollView{
                
                if let photoData = results{
                    VStack{
                        ForEach(photoData.hits, id: \.self.id){ hit in
                            
                            
                            AsyncImage(url: URL(string:hit.largeImageURL)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .overlay{
                                        if isSelected.contains(hit.id){
                                            Rectangle()
                                                .stroke(Color.blue, lineWidth: 4)
                                        }
                                    }
                                    .overlay(alignment: .bottomTrailing){
                                        if isSelected.contains(hit.id){
                                            
                                            
                                            Image(systemName: "checkmark.circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .foregroundStyle(.blue)
                                                .padding()
                                        }
                                        
                                        
                                        //
                                    }
                                    .onTapGesture {
                                        if isSelected.contains(hit.id){
                                            if let index = isSelected.firstIndex(of: hit.id){
                                                isSelected.remove(at: index)
                                                photosURL.remove(at: index)
                                            }
                                            
                                        } else {
                                            isSelected.append(hit.id)
                                            photosURL.append(hit.largeImageURL)
                                        }
                                    }
                                    .padding(.vertical,10)
                                
                            } placeholder: {
                                ProgressView()
                                
                            }
                        }
                        
                        
                        
                    }
                    
                } else{
                    ContentUnavailableView("No photos found", systemImage: "camera.on.rectangle.fill")
                }
            }
            .padding(.horizontal, 26)
//            .padding()
            .navigationTitle("PixelBay Library")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("Add"){
//                        choosenImages.removeAll()
                        if choosenImages == nil{
                            choosenImages = [Data]()
                        }
                        fetchImageData(from: photosURL)
                        dismiss()
                    }
                    
                    .disabled(isSelected.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
//            .accentColor(.blue)
        }
//        .accentColor(.blue)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isFocused = true
            }
        }
        
        
    }
    // Fetching image data
    func fetchImageData(from photosURL: [String]){
        for photo in photosURL{
            Task{
                do{
                    let url = URL(string: photo)
                    let (data, _) = try await URLSession.shared.data(from: url!)
                    DispatchQueue.main.async {
                        self.choosenImages!.append(data)
                    }
                }catch {
                    print("Error fetching image data: \(error)")
                }
            }
        }
//         Task {
//             do {
//                 let (data, _) = try await URLSession.shared.data(from: url)
//                 DispatchQueue.main.async {
//                     return data
//                 }
//             } catch {
//                 print("Error fetching image data: \(error)")
//             }
//         }
     }
//             Starts the pulsating animation for the currently selected button.
             func loadData() async {
                 guard let url = URL(string: "https://pixabay.com/api/?key=47290689-3f6c05edc5963c3c49947b2b2&q=\(searchPrompt.replacingOccurrences(of: " ", with: "+"))&image_type=photo&pretty=true") else { print("wrong url"); return}
                 do{
                     let (data, _) = try await URLSession.shared.data(from: url)
                         print(data)
                     if let decodedResponse = try? JSONDecoder().decode(Results.self, from: data) {
                         results = decodedResponse
                     }
                     
                 }catch{
                     print("error while getting data")
                 }
            }
        }


//        ScrollView{
    
//                ZStack{
//
//                    VStack{
//                        Rectangle()
//                            .fill(Color.red)
//                            .frame(width: 200, height: 200)
//                            .clipShape(.rect(cornerRadius: 10))
//                            .rotationEffect(.degrees(!testBool ? 0:Double(Int.random(in: -10...10))))
//                    }
//                    VStack{
//                        Rectangle()
//                            .fill(Color.green)
//                            .frame(width: 200, height: 200)
//                            .clipShape(.rect(cornerRadius: 10))
//                            .rotationEffect(.degrees(!testBool ? 0:Double(Int.random(in: -10...10))))
//    //                        .padding(.top,200)
//                    }
//                    .offset(y:testBool ? 0:210)
//                    VStack{
//                        Rectangle()
//                            .fill(Color.blue)
//                            .frame(width: 200, height: 200)
//                            .clipShape(.rect(cornerRadius: 10))
//                            .rotationEffect(.degrees(!testBool ? 0:Double(Int.random(in: -10...10))))
//                    }
//                    .offset(y: testBool ? 0:420)
//                    VStack{
//                        Rectangle()
//                            .fill(Color.blue)
//                            .frame(width: 200, height: 200)
//                            .clipShape(.rect(cornerRadius: 10))
//                            .rotationEffect(.degrees(!testBool ? 0:Double(Int.random(in: -10...10))))
//                    }
//                    .offset(y: testBool ? 0:630)
//
//                    Text(testString.capitalizedSentence)
//                }
//                .frame(maxWidth: .infinity)
//                .onTapGesture {
//                    number += 1
//                    withAnimation{
//                        testBool.toggle()
//                    }
//                }
            
//            Text("\(number)")
//        }
    


//struct TestView: View {
//    @State private var date = Date.now
////    let components = DateComponents(year: 2024, month: 11, day: 22)
//    @State private var month: Int = 0
//
//    var body: some View {
//        Button("Tap me"){
//            month = Calendar.current.component(.month, from: date)
//        }
//        Text("\(month)")
//    }
//}

#Preview {
//    var image: Image?
    let exampleData: [Data] = [
                UIImage(systemName: "star")?.jpegData(compressionQuality: 1.0),
                UIImage(systemName: "moon")?.jpegData(compressionQuality: 1.0),
                UIImage(systemName: "sun.max")?.jpegData(compressionQuality: 1.0)
            ].compactMap { $0 } // Remove any nil values
    OnlinePhotosView(choosenImages: .constant(exampleData))
}
