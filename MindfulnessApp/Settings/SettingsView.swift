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
                
                ScrollViewReader { value in
                    ScrollView{
                        
                        VStack{
                            Image(.settingsVector)
                                .id(0)
                            Text("Oskar")
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .padding(.top, -20)
                            Text("Personal info...")
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                            Rectangle()
                                .frame(width: 314, height: 1)
                                .foregroundStyle(Color("Settings"))
                            AccountAndPrivacyView(selectedSetting: $numTapped)
                                .id(1)
                                
                            AppearanceAndThemeView(selectedSetting: $numTapped)
                                .id(2)
                                
                            DataManagementView(selectedSetting: $numTapped)
                                .id(3)
                                
                            NotificationsView(selectedSetting: $numTapped)
                                .id(4)
                                
                            DarkModeView(selectedSetting: $numTapped)
                                .id(5)
                                
                            FeedbackView(selectedSetting: $numTapped)
                                .id(6)
                                
                            HelpAndSupportView(selectedSetting: $numTapped)
                                .id(7)
                            
                            HapticsView(selectedSetting: $numTapped)
                                .id(8)
                            
                            NewFeaturesView(selectedSetting: $numTapped)
                                .id(9)
                            
                            Rectangle()
                                .frame(width: 314, height: 50)
                                .opacity(0)
                                .id(10)
                               
                            //                        ForEach(1..<10){ num in
                            //                            Button{
                            //                                if numTapped == num{
                            //                                    withAnimation{
                            //                                        numTapped = 0
                            //                                    }
                            //                                }else{
                            //                                    withAnimation{
                            //                                        numTapped = num
                            //                                    }
                            //                                }
                            //
                            //                            }label: {
                            //                                ZStack{
                            //                                    RoundedRectangle(cornerRadius: 10)
                            //                                        .frame(width: 347, height: numTapped == num ? 100 : 50)
                            //                                        .settingsViewColor()
                            //
                            //                                    VStack{
                            //                                        HStack{
                            //                                            Group{
                            //                                                Circle()
                            //                                                    .frame(width:18, height: 18)
                            //                                                    .foregroundStyle(.orange)
                            //
                            //                                                Text({
                            //                                                    switch num{
                            //                                                    case 1: return "Homescreen"
                            //                                                    case 2: return "Journal"
                            //                                                    case 3: return "Meditation"
                            //                                                    case 4: return "Night Mode"
                            //                                                    case 5: return "Privacy"
                            //                                                    case 6: return "Feedback"
                            //                                                    case 7: return "Notifications"
                            //                                                    case 8: return "App Info"
                            //                                                    case 9: return "Support"
                            //                                                    default: return "Error"
                            //                                                    }
                            //                                                }())
                            //                                                    .font(.system(size: 18, weight: .medium, design: .rounded))
                            //                                                    .foregroundStyle(.white)
                            //                                                    .lineLimit(1)
                            //
                            //                                                Image(systemName: "chevron.forward")
                            //                                                    .foregroundStyle(.white)
                            //                                                    .rotationEffect(Angle(degrees: numTapped == num ? 90 : 0))
                            //                                            }
                            //                                            .padding()
                            //                                            .padding(.horizontal, 20)
                            //                                        }
                            ////                                        .background(.red)
                            //                                        if numTapped == num{
                            //                                            Spacer()
                            //                                            Text("Settings")
                            //                                                .foregroundStyle(.white)
                            //                                                .padding(.bottom)
                            //                                        }
                            ////                                        Spacer()
                            //                                        ////Settings content
                            //
                            //                                    }
                            //
                            //                                }
                            //                            }
                            //
                            //                        }
                            
                        }
                        .scrollIndicators(.hidden)
                        .padding(.bottom)
                    }
                    .onChange(of: numTapped) { oldValue, newValue in
                        withAnimation{
                            if newValue == 0{
                                value.scrollTo(0)
                            }else{
                                value.scrollTo(numTapped+1)
                            }
                        }
                    }
                    
                }
                
                
                
                
            }
            .toolbarBackground(Color("Settings"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
        .sensoryFeedback(.increase, trigger: numTapped)
        .accentColor(.white)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SettingsView()
}
