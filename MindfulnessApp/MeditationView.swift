//
//  MeditationView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI

struct MeditationView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                
                Rectangle()
                    .foregroundStyle(Color("MeditationBackground"))
                    .ignoresSafeArea()
                
                VStack{
                    Spacer()
                    
                    Image(.meditationVector2)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        
                
                }
                
                VStack{
                    Image(.meditationVector)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                    
                    Spacer()

                }
                
                VStack{
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 22)
                        .frame(width: 330, height: 106)
                        .foregroundStyle(.ultraThinMaterial)
                        .padding(7)
                    
                    RoundedRectangle(cornerRadius: 22)
                        .frame(width: 330, height: 221)
                        .foregroundStyle(.ultraThinMaterial)
                        .padding(7)
                    
                    RoundedRectangle(cornerRadius: 22)
                        .frame(width: 195, height: 58)
                        .foregroundStyle(.ultraThinMaterial)
                        .padding(.bottom, 35.0)
                        .padding(.top, 7)
                }
                
            }
            .toolbarBackground(Color("Meditation"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    MeditationView()
}
