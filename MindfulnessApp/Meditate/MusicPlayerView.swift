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
                ZStack{
                    RoundedRectangle(cornerRadius: 33)
                        .foregroundStyle(.ultraThinMaterial)
                        .frame(width: 356, height: 299)
                        .padding(.bottom, 19)
                    Button("Cancel"){
                        //
                    }
                }
            }
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    MusicPlayerView()
}
