//
//  MeditationView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI

struct MeditationView: View {
    @State private var tabbarVisibility = Visibility.visible
    @State private var opacity = 1.0
    var body: some View {
        NavigationStack{
            ZStack{
                
                Rectangle()
                    .foregroundStyle(Color("MeditationBackground"))
                    .ignoresSafeArea()
                
                //SandCircles
                VStack{
                    Spacer()
                    
                    Image(.meditationVector2)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .opacity(opacity)
                        .animation(.easeInOut(duration:opacity == 1.0 ? 0.5:0.01).delay(0.3), value: opacity)
                        
                
                }
                
                //Lili
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
                        .opacity(opacity)
                        .animation(.easeInOut(duration:opacity == 1.0 ? 0.5:0.01).delay(0.3), value: opacity)
                    
                    RoundedRectangle(cornerRadius: 22)
                        .frame(width: 330, height: 221)
                        .foregroundStyle(.ultraThinMaterial)
                        .padding(7)
                        .opacity(opacity)
                        .animation(.easeInOut(duration:opacity == 1.0 ? 0.5:0.01).delay(0.3), value: opacity)
                    
                    NavigationLink {
                        MusicPlayerView()
                            .onAppear {
                                    tabbarVisibility = .hidden
                                    opacity = 0.0
                            }
                            .onDisappear{
                                    tabbarVisibility = .visible
                                opacity = 1.0
                            }
                            
                    } label: {
                        ZStack{
                            Group{
                                RoundedRectangle(cornerRadius: 22)
                                    .foregroundStyle(.ultraThinMaterial)
                                    
                                Text("START")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color("MeditationFontColor"))
                                
                            }
                            .frame(width: 195, height: 58)
                            .padding(.bottom, 35.0)
                            .padding(.top, 7)
                            .opacity(opacity)
                            .animation(.easeInOut(duration:opacity == 1.0 ? 0.5:0.01).delay(0.3), value: opacity)
                            
                        }
                    }
            
                }
                .preferredColorScheme(.light)
                
            }
            .toolbarBackground(Color("Meditation"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
        .toolbar(tabbarVisibility, for: .tabBar)
        .animation(.easeInOut(duration:0.2), value: tabbarVisibility)
        .accentColor(.white)
    }
}

#Preview {
    MeditationView()
}
