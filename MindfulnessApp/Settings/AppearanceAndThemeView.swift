//
//  AppearanceAndThemeView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 5/12/24.
//

import SwiftUI

struct AppearanceAndThemeView: View {
    @Binding var selectedSetting: Int
//    @State private var selectedSetting = 0 // zmien na 0
    @State private var isChoosingStats = false // zmen na false
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                Group{
                    Button{
                        withAnimation{
                            if selectedSetting == 2{
                                selectedSetting = 0
                            }else{
                                selectedSetting = 2
                            }
                            
                        }
                    } label: {
                        Text("Appearance & Theme")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.leading, 50)
                            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                            .foregroundStyle(.white)
                            .background{
                                
                                if isChoosingStats{
                                    Rectangle()
                                        .foregroundStyle(.gray.opacity(0.3))
                                }
                                
                            }
                            .overlay(alignment: .trailing) {
                                Image(systemName: "chevron.forward")
                                    .padding(.horizontal)
                                    .foregroundStyle(.white)
                                    .rotationEffect(Angle(degrees: isChoosingStats ? 90 : 0))
                            }
                            .overlay(alignment: .leading) {
                                Circle()
                                    .frame(width: 18, height: 18)
                                    .padding(.horizontal)
                                    .foregroundStyle(.orange)
                                
                            }
                    }
                    if selectedSetting == 2{
                        
                        ScrollView{
//                            VStack(spacing:15){
//                                VStack{
//                                    Text("Home Screen")
//                                        .foregroundStyle(.white)
//                                        .font(.system(size:18, weight: .medium, design: .rounded))
//                                }
//                                
//                                Rectangle()
//                                    .frame(width:300, height: 1)
//                                    .foregroundStyle(.gray.opacity(0.5))
//                                
//                                VStack{
//                                    Text("Meditation")
//                                        .foregroundStyle(.white)
//                                        .font(.system(size:18, weight: .medium, design: .rounded))
//                                }
//                                
//                                Rectangle()
//                                    .frame(width:300, height: 1)
//                                    .foregroundStyle(.gray.opacity(0.5))
//                                
//                                VStack{
//                                    Text("Sleep Calculator")
//                                        .foregroundStyle(.white)
//                                        .font(.system(size:18, weight: .medium, design: .rounded))
//                                }
//                                
//                                Rectangle()
//                                    .frame(width:300, height: 1)
//                                    .foregroundStyle(.gray.opacity(0.5))
//                                
//                                VStack{
//                                    Text("Journal")
//                                        .foregroundStyle(.white)
//                                        .font(.system(size:18, weight: .medium, design: .rounded))
//                                }
//                                
//                                
//                            }
//                            .padding(.top, 15)
                            Image(.commingSoonVector)
                                .resizable()
                                .scaledToFit()
                                .frame(width:250)
                                .padding(.top, 15)
//                                .background(.red)
                        }
                        .scrollBounceBehavior(.basedOnSize)
                        .scrollIndicators(.hidden)
                        .padding(.bottom, 5)
                    }
                    
                }
                
            }
            .frame(width: 345, height: selectedSetting == 2 ? 200 : 50)
            .background{
                Rectangle()
                    .settingsViewColor()
                //                    .frame(width: 352, height: 50)
            }
            .clipShape(.rect(cornerRadius: 35))
        }
        .onChange(of: selectedSetting) { oldValue, newValue in
            withAnimation{
                if newValue == 2 {
                    isChoosingStats = true
                } else{
                    isChoosingStats = false
                }
                
                
                
            }
        }
    }
}

#Preview {
    AppearanceAndThemeView(selectedSetting: .constant(1))
}

