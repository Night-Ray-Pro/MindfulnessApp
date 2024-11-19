//
//  SettingsView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var numTapped = 0
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .ignoresSafeArea()
                    .settingsViewGradient()
                
                    
                    ScrollView{
                        
                        VStack{
                            Image(.settingsVector)
                            Text("Oskar")
                                .font(.custom("Cochin", size: 48))
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding(.top, -20)
                            Text("Personal info...")
                                .font(.custom("Cochin", size: 32))
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            Rectangle()
                                .frame(width: 314, height: 1)
                                .foregroundStyle(Color("Settings"))
                        
                        ForEach(1..<10){ num in
                            Button{
                                if numTapped == num{
                                    withAnimation{
                                        numTapped = 0
                                    }
                                }else{
                                    withAnimation{
                                        numTapped = num
                                    }
                                }
                                
                            }label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 347, height: numTapped == num ? 100 : 50)
                                        .settingsViewColor()
                                    
                                    VStack{
                                        HStack{
                                            Group{
                                                Circle()
                                                    .frame(width:18, height: 18)
                                                    .foregroundStyle(.orange)
                                                Spacer()
                                                Image(systemName: "chevron.forward")
                                                    .foregroundStyle(.white)
                                                    .rotationEffect(Angle(degrees: numTapped == num ? 90 : 0))
                                            }
                                            .padding()
                                            .padding(.horizontal, 20)
                                        }
//                                        .background(.red)
                                        if numTapped == num{
                                            Spacer()
                                            Text("Settings")
                                                .foregroundStyle(.white)
                                                .padding(.bottom)
                                        }
//                                        Spacer()
                                        ////Settings content
                                        
                                    }
                                    
                                }
                            }
                            
                        }
                        
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .toolbarBackground(Color("Settings"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    SettingsView()
}
