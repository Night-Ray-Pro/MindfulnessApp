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
    @State private var isBreathing = false
    @State private var playbackDuration: Int = 5
    @State private var currentDurationOffset = -108
    @State private var currentEmotionOffset = 115
    @State private var selectedTheme: Int = 0
    let duration: [Int] = [5, 10, 15, 20]
    let durationOffsets = [-108, -36, 36, 108]
    let emotionsOffsets = [-115, -57, 0 , 57, 115]
    let themes = ["relax", "focus"]
    let emotes = ["angry", "worried", "sad", "sleepy", "mind"]
    @State private var selectedEmotion: Int = 4
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
                    ZStack{
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 330, height: 106)
                            .foregroundStyle(.ultraThickMaterial)
                            .foregroundStyle(.ultraThinMaterial)
                            .padding(7)
                            
                            
                        VStack(alignment: .leading){
                            Text("How are you feeling?")
                                .foregroundStyle(Color("MeditationFontColor"))
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .padding(.horizontal, 10)
                                
                            ZStack{
                               
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("MeditationFontColor"), lineWidth: 1)
                                    .frame(width:44, height: 44)
                                    .offset(x: CGFloat(currentEmotionOffset), y: -10)
                                
                                HStack{
                                    ForEach(0..<5){ num in
                                        Spacer()
                                        Button{
                                            withAnimation(.easeOut){
                                                selectedEmotion = num
                                            }
                                            withAnimation(.snappy(duration: 0.4, extraBounce:0.01)){
                                                currentEmotionOffset = emotionsOffsets[num]
                                            }
                                        } label: {
                                            VStack(alignment: .center){
                                                Image("\(emotes[num])Vector")
                                                    .resizable()
                                                    .frame(width:44, height: 44)
                                                    .scaledToFit()
                                   
                                                
                                                Text(emotes[num].capitalizedSentence)
                                                    .foregroundStyle(Color("MeditationFontColor"))
                                                    .font(.system(size: selectedEmotion == num ? 12 : 10, weight: .bold, design: .rounded))
                                            }
                                            
                                        }
                                        
                                    }
                                    Spacer()
                                }
                                .frame(width:300)
                            }
                            
                        }
//                        .padding(.vertical)
                        
                    }
                    .opacity(opacity)
                    .animation(.easeInOut(duration:opacity == 1.0 ? 0.5:0.01).delay(0.3), value: opacity)
//                    .background(.red)
                    .buttonStyle(.plain)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 330, height: 241)
                            .foregroundStyle(.ultraThickMaterial)
                            .padding(7)
                            
                        VStack(alignment: .leading){
                            Text("Duration")
                                .foregroundStyle(Color("MeditationFontColor"))
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                            
                        
                            //Timing buttons
                            ZStack{
                                HStack{
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("MeditationFontColor"), lineWidth: 1)
                                        .frame(width: 60, height: 50)
                                        .offset(x:CGFloat(currentDurationOffset))
                                }
                                .frame(width:300)
                                
                                HStack{
                                    ForEach(duration, id: \.self){ num in
                                        Spacer()
                                        Button{
                                            withAnimation(.easeOut){
                                                playbackDuration = num
                                            }
                                            withAnimation(.snappy(duration: 0.4, extraBounce:0.01)){
                                                let index = duration.firstIndex(of: num)!
                                                currentDurationOffset = durationOffsets[index]
                                            }
                                        } label: {
                                            VStack(alignment: .center){
                                                Text("\(num)")
                                                    .foregroundStyle(Color("MeditationFontColor"))
                                                    .font(.system(size: playbackDuration == num ? 17 : 15, weight: .bold, design: .rounded))
                                                
                                                
                                                Text("min")
                                                    .foregroundStyle(Color("MeditationFontColor"))
                                                    .font(.system(size: playbackDuration == num ? 12 : 10, weight: .bold, design: .rounded))
                                            }
                                            .frame(width: 60, height: 50)
                                            
                                            
                                        }
                                        
                                    }
                                    Spacer()
                                }
                            }
//                            .background(.red)
                            .frame(width:300)
                            
                            
                            Rectangle()
                                .frame(width: 269, height: 1, alignment: .center)
                                .foregroundStyle(Color("MeditationFontColor"))
                                .frame(width: 300, height: 1, alignment: .center)
                                .padding(.vertical, 5)
                            
                            
                            Text("Theme")
                                .foregroundStyle(Color("MeditationFontColor"))
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .padding(.horizontal, 10)
                            
                            //Flowi buttons
                            HStack{
                                ForEach(0..<2){ num in
                                    Spacer()
                                    Button{
                                        withAnimation{
                                            selectedTheme = num
                                            startPulsating()
                                        }
                                    } label: {
                                        VStack(alignment: .center){
                                             
                                                Image("\(themes[num])FlowiVector")
                                                    .resizable()
                                                    .frame(width: num == 0 ? 45: 52, height: num == 0 ? 45:52)
                                                    .scaledToFit()
                                                    .scaleEffect(selectedTheme == num && isBreathing ? 1.1 : 1.0)
                                                    .animation(
                                                        selectedTheme == num && isBreathing
                                                            ? Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
                                                            : .default,
                                                        value: isBreathing
                                                    )
//                                                    .animation(.easeInOut.repeatForever())
                                            
                                            
                                            Text("\(themes[num].capitalizedSentence)")
                                                .foregroundStyle(Color("MeditationFontColor"))
                                                .font(.system(size: selectedTheme == num ? 17 : 16, weight: .bold, design: .rounded))
                                        }
                                        .frame(height: 100)
//                                        .background(.red)
                                        
                                        
                                    }
                                    
                                }
                                Spacer()
                            }
                            .frame(width:300)
                            
                        }
                        .padding(.vertical)
                    }
                    .opacity(opacity)
                    .animation(.easeInOut(duration:opacity == 1.0 ? 0.5:0.01).delay(0.3), value: opacity)
                    .padding(.vertical,-20)
//                    .background(.red)
                    .buttonStyle(.plain)
//                    .background(content: .red)
                    
                    NavigationLink {
                        MusicPlayerView(length: playbackDuration, theme: themes[selectedTheme])
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
                                    .foregroundStyle(.ultraThickMaterial)
                                    
                                Text("START")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color("MeditationFontColor"))
                                
                            }
                            .frame(width: 195, height: 58)
                            .padding(.bottom, 30.0)
                            .padding(.top, 7)
                            .opacity(opacity)
                            .animation(.easeInOut(duration:opacity == 1.0 ? 0.5:0.01).delay(0.3), value: opacity)
                            
                        }
                    }
//                    .background(.red)
            
                }
                .preferredColorScheme(.light)
                
            }
            .toolbarBackground(Color("Meditation"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
        .onAppear{
            isBreathing = false
            isBreathing.toggle()
        }
       
        .toolbar(tabbarVisibility, for: .tabBar)
        .animation(.easeInOut(duration:0.2), value: tabbarVisibility)
//        .accentColor(.white)
    }
    private func startPulsating() {
        isBreathing = false // Stop any existing pulsation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isBreathing = true // Restart the animation for the new button
        }
    }
}

extension String {
    var capitalizedSentence: String {
        // 1
        let firstLetter = self.prefix(1).capitalized
        // 2
        let remainingLetters = self.dropFirst().lowercased()
        // 3
        return firstLetter + remainingLetters
    }
}

#Preview {
    MeditationView()
}
