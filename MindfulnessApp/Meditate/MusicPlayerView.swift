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
                Spacer()
                
                MusicPlayerTest()
                
            }
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    MusicPlayerView()
}
