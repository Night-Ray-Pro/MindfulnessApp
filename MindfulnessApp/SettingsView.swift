//
//  SettingsView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI

struct SettingsView: View {
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
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 347, height: 50)
                                    .settingsViewColor()
                                
                                HStack{
                                    Group{
                                        Circle()
                                            .frame(width:25)
                                            .foregroundStyle(.orange)
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .foregroundStyle(.white)
                                    }
                                    .padding()
                                }
                                .frame(width: 347, height: 50)
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
