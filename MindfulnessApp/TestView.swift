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
    var previewWidth : Int
    var previewHeight : Int
    var webformatURL : String
}

struct TestView: View {
    @State private var number = 1
    @State private var testBool = true
    let testString = "hello"
    @State private var selectedButton: Int? = 1
    @State private var pulsate = false
    @State private var results: Results?
    var body: some View {
        Text(results?.hits.first?.previewURL ?? "Hello World")
            .task {
                await loadData()
            }
            }

            /// Starts the pulsating animation for the currently selected button.
             func loadData() async {
                 guard let url = URL(string: "https://pixabay.com/api/?key=47290689-3f6c05edc5963c3c49947b2b2&q=yellow+flowers&image_type=photo&pretty=true") else { print("wrong url"); return}
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
    TestView()
}
