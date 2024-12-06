//
//  NewFeaturesView.swift
//  MindfulnessApp
//
//  Created by Jakub Kalina on 06/12/2024.
//

import SwiftUI

struct NewFeaturesView: View {
    @Binding var selectedSetting: Int
//    @State private var selectedSetting = 0 //// zmien na 0
    @State private var isChoosingStats = false // zmen na false
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                Group{
                    Button{
                        withAnimation{
                            if selectedSetting == 9{
                                selectedSetting = 0
                            }else{
                                selectedSetting = 9
                            }
                            
                        }
                    } label: {
                        Text("New Features")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.leading, 50)
                            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                            .foregroundStyle(.white)
                            .background{
                                
                                if isChoosingStats{
                                    Rectangle()
                                        .foregroundStyle(.gray.opacity(0.3))
                                }
                                
                            }
                            .overlay(alignment: .trailing) {
                                Image(systemName: "chevron.forward")
                                    .padding(.horizontal)
                                    .foregroundStyle(.white)
                                    .rotationEffect(Angle(degrees: isChoosingStats ? 90 : 0))
                            }
                            .overlay(alignment: .leading) {
                                Circle()
                                    .frame(width: 18, height: 18)
                                    .padding(.horizontal)
                                    .foregroundStyle(.orange)
                                
                            }
                    }
                    if selectedSetting == 9{
                        
                        ScrollView{
                            VStack(spacing: 10){
                                HStack{
                                    VStack{
                                        Image(.AppIconImage)
                                            .scaledToFit()
                                        Text("MindFlow")
                                            .font(.system(size: 16, weight: .bold, design: .rounded))
                                            .foregroundStyle(.white)
                                    }
                                    .multilineTextAlignment(.center)
                                    .padding(.leading, 50)
                                    
                                    VStack{
                                        Text("Version ").font(.system(size: 16, weight: .bold, design: .rounded)) + Text("\(getAppVersion())").font(.system(size: 16, weight: .medium, design: .default)).italic()
                                        Text("Build ").font(.system(size: 16, weight: .bold, design: .rounded)) + Text("\(getBuildNumber())").font(.system(size: 16, weight: .medium, design: .default)).italic()
                                    }
                                    .multilineTextAlignment(.center)
                                    .padding(.trailing, 45)
                                }
                            }
                            .frame(width:250)
                            .foregroundStyle(.white)
                            
                        }
                        .scrollBounceBehavior(.basedOnSize)
                        .scrollIndicators(.hidden)
                        .padding(.vertical, 10)
                    }
                    
                }
                
            }
            .frame(width: 345, height: selectedSetting == 9 ? 370 : 50)
            .background{
                Rectangle()
                    .settingsViewColor()
                //                    .frame(width: 352, height: 50)
            }
            .clipShape(.rect(cornerRadius: 35))
        }
        .onChange(of: selectedSetting) { oldValue, newValue in
            withAnimation{
                if newValue == 9 {
                    isChoosingStats = true
                } else{
                    isChoosingStats = false
                }
                
                
                
            }
        }
        
    }
    func getAppVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return appVersion
        }
        return "Unknown"
    }
    func getBuildNumber() -> String {
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return buildNumber
        }
        return "Unknown"
    }
}


#Preview {
    NewFeaturesView(selectedSetting: .constant(9))
}
