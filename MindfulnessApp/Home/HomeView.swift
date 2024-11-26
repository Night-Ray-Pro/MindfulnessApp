//
//  HomeView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI
import BottomSheet

struct HomeView: View {
    @State private var hour:Int = Calendar.current.component(.hour, from: .now)
    @State private var mode: Bool = true
    
    var body: some View {
        NavigationStack{
            VStack{
                if mode{
                    LightView()
                } else{
                    DarkView()
                }
                
            }
            .toolbarBackground(Color(mode ? "HomeDay":"HomeNight"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
        .onAppear{
            setMode()
        }
    }
    
    func setMode(){
        hour = Calendar.current.component(.hour, from: .now)
        if hour > 5 && hour < 18{
            mode = true
        } else{
            mode = false
        }
    }
}

struct LightView: View{
    @State private var position: BottomSheetPosition = .relative(0.51)
    
    var body: some View {
        ZStack{
            VStack{
                Rectangle()
                    .frame(height:290)
                    .homeDayViewGradient()
                    .ignoresSafeArea()
                Spacer()
            }
            
            VStack{
                Spacer()
                
                Image(.homeLightVector)
                    .resizable()
                    .scaledToFit()
                    
            }
            
            VStack{
                Text("Morning!")
                    .foregroundStyle(.white)
                    .font(.system(size: 48, weight: .semibold, design: .rounded))
                Text("Oskar")
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                Spacer()
            }

        }
        .bottomSheet(bottomSheetPosition: self.$position, switchablePositions: [
            .relative(0.51),
            .relativeTop(0.975)
        ], headerContent: {
            Text("Quote of the Day")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding([.horizontal, .bottom])
        })  {
            ScrollView {
                ForEach(1..<10) { num in
                    Text("This is \(num) line")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .bottom])
                }
            }
        }
//        .dragIndicatorColor(Color(red: 0.17, green: 0.17, blue: 0.33))
        .customBackground(
            Color("homeLightSheet")
                .cornerRadius(30)
        )
        .foregroundColor(.white)
    }
}

struct DarkView: View{
    @State var position: BottomSheetPosition = .relative(0.51)
        
        var body: some View {
            ZStack{
                //Gradient
                VStack{
                    Rectangle()
                        .frame(height:310)
                        .homeNightViewGradient()
                        .ignoresSafeArea()
                    Spacer()
                }
                //Graphics
                VStack{
                    Spacer()
                    
                    Image(.homeDarkVector)
                        .resizable()
                        .scaledToFit()
                        
                        
                }
                //Text
                VStack{
                    Text("Evening!")
                        .foregroundStyle(.white)
                        .font(.system(size: 48, weight: .semibold, design: .rounded))
                    Text("Oskar")
                        .foregroundStyle(.white)
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                    Spacer()
                }

            }
            .bottomSheet(bottomSheetPosition: self.$position, switchablePositions: [
                .relative(0.51),
                .relativeTop(0.975)
            ], headerContent: {
                Text("Quote of the Day")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding([.horizontal, .bottom])
            })  {
                ScrollView {
                    ForEach(1..<10) { num in
                        Text("This is \(num) line")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, .bottom])
                    }
                }
            }
    //        .dragIndicatorColor(Color(red: 0.17, green: 0.17, blue: 0.33))
            .customBackground(
                Color("homeDarkSheet")
                    .cornerRadius(30)
            )
            .foregroundColor(.white)
        }
}

#Preview {
    HomeView()
}
