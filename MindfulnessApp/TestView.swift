//
//  TestView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 22/11/24.
//

import SwiftUI

struct TestView: View {
    @State private var number = 1
    @State private var testBool = true
    let testString = "hello"
    @State private var selectedButton: Int? = 1
    @State private var pulsate = false
    
    var body: some View {


        
            

            
                HStack(spacing: 40) {
                    // First Button
                    Button(action: {
                       
                            selectedButton = 1
                            startPulsating()
                        
                    }) {
                        Text("Button 1")
                            .padding()
                            .background(Circle().fill(selectedButton == 1 ? Color.blue : Color.gray))
                            .foregroundColor(.white)
                            .scaleEffect(selectedButton == 1 && pulsate ? 1.2 : 1.0)
                            .animation(
                                selectedButton == 1 && pulsate
                                    ? Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)
                                    : .default,
                                value: pulsate
                            )
                    }

                    // Second Button
                    Button(action: {
                        
                            selectedButton = 2
                            startPulsating()
                        
                    }) {
                        Text("Button 2")
                            .padding()
                            .background(Circle().fill(selectedButton == 2 ? Color.green : Color.gray))
                            .foregroundColor(.white)
                            .scaleEffect(selectedButton == 2 && pulsate ? 1.2 : 1.0)
                            .animation(
                                selectedButton == 2 && pulsate
                                    ? Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)
                                    : .default,
                                value: pulsate
                            )
                    }
                }
                .onAppear{
                    pulsate.toggle()}
                .padding()
            }

            /// Starts the pulsating animation for the currently selected button.
            private func startPulsating() {
                pulsate = false // Stop any existing pulsation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    pulsate = true // Restart the animation for the new button
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
