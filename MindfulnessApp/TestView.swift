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
    
    var body: some View {
        ScrollView{
    
                ZStack{
                    VStack{
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 200, height: 200)
                            .clipShape(.rect(cornerRadius: 10))
                            .rotationEffect(.degrees(!testBool ? 0:Double(Int.random(in: -10...10))))
                    }
                    VStack{
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: 200, height: 200)
                            .clipShape(.rect(cornerRadius: 10))
                            .rotationEffect(.degrees(!testBool ? 0:Double(Int.random(in: -10...10))))
    //                        .padding(.top,200)
                    }
                    .offset(y:testBool ? 0:210)
                    VStack{
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 200, height: 200)
                            .clipShape(.rect(cornerRadius: 10))
                            .rotationEffect(.degrees(!testBool ? 0:Double(Int.random(in: -10...10))))
                    }
                    .offset(y: testBool ? 0:420)
                    VStack{
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 200, height: 200)
                            .clipShape(.rect(cornerRadius: 10))
                            .rotationEffect(.degrees(!testBool ? 0:Double(Int.random(in: -10...10))))
                    }
                    .offset(y: testBool ? 0:630)
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    number += 1
                    withAnimation{
                        testBool.toggle()
                    }
                }
            
//            Text("\(number)")
        }
    }
}

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
