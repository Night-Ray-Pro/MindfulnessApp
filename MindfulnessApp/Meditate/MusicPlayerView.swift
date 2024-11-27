//
//  MusicPlayerView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 17/11/24.
//

import SwiftUI

struct MusicPlayerView: View {
    var body: some View {
        
        ZStack{
            
            Image(.musicPlayerVector)
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("Relax")
                    .foregroundStyle(.white)
                    .font(.system(size: 48, weight: .bold, design: .rounded))
//                    .padding(10)
                Spacer()
            }
            VStack{
                Spacer()
                
                MusicPlayerTest()
                    .padding(.bottom,15)
                
            }
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    MusicPlayerView()
}
