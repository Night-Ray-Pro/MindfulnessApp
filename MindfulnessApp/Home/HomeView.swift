//
//  HomeView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI
import BottomSheet

struct HomeView: View {
    @Environment(\.scenePhase) var scenePhase
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
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active {
                withAnimation{
                    setMode()
                }
//                print("Active")
            }
//                        } else if newPhase == .inactive {
//                            print("Inactive")
//                        } else if newPhase == .background {
//                            print("Background")
//                        }
        }
        .onAppear{
            setMode()
        }
    }
    
    func setMode(){
//        print("settingMode")
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
            //Gradient
            VStack{
                Rectangle()
                    .frame(height:310)
                    .homeDayViewGradient()
                    .ignoresSafeArea()
                Spacer()
            }
            //Graphics
            VStack{
                Spacer()
                
                Image(.homeLightVector)
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 80)
                    
                    
            }
            //Text
            VStack{
                Text("Morning!")
                    .foregroundStyle(.white)
                    .font(.system(size: 48, weight: .semibold, design: .rounded))
                Text("Oskar")
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                Spacer()
            }
            .padding(.top, 60)

        }
        .ignoresSafeArea()
        .bottomSheet(bottomSheetPosition: self.$position, switchablePositions: [
            .relative(0.51),
            .relativeTop(0.975)
        ], headerContent: {
            Text("Dashboard")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding([.horizontal, .bottom])
                .padding(.leading,15)
        })  {
            SheetView()
                .preferredColorScheme(.light)
            //hhhi
        }
//        .dragIndicatorColor(Color(red: 0.17, green: 0.17, blue: 0.33))
        .customBackground(
            Color("homeLightSheet")
                .cornerRadius(30)
//                Image(.homeSheetDayBackground)
//                    .resizable()
//                    .scaledToFit()
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
                        .padding(.bottom, 80)
                        
                        
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
                .padding(.top, 60)

            }
            .ignoresSafeArea()
            .bottomSheet(bottomSheetPosition: self.$position, switchablePositions: [
                .relative(0.51),
                .relativeTop(0.975)
            ], headerContent: {
                Text("Dashboard")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding([.horizontal, .bottom])
                    .padding(.leading,15)
            })  {
                SheetView()
                    .preferredColorScheme(.light)
                //hhhi
            }
    //        .dragIndicatorColor(Color(red: 0.17, green: 0.17, blue: 0.33))
            .customBackground(
                Color("homeDarkSheet")
                    .cornerRadius(30)
//                Image(.homeSheetDayBackground)
//                    .resizable()
//                    .scaledToFit()
            )
            .foregroundColor(.white)
        }
}

#Preview {
    HomeView()
}
