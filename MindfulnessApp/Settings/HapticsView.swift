//
//  HapticsView.swift
//  MindfulnessApp
//
//  Created by Jakub Kalina on 06/12/2024.
//

import SwiftUI

struct HapticsView: View {
    @Binding var selectedSetting: Int
//    @State private var selectedSetting = 0 // zmien na 0
    @State private var isChoosingStats = false // zmen na false
    @AppStorage("haptics") var haptics = false
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                Group{
                    Button{
                        withAnimation{
                            if selectedSetting == 8{
                                selectedSetting = 0
                            }else{
                                selectedSetting = 8
                            }
                            
                        }
                    } label: {
                        Text("Haptics")
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
                    if selectedSetting == 8{
                        
                        ScrollView{
                            Toggle(isOn: $haptics){
                                
                                Text(haptics ? "Enabled":"Disabled")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                            }
                                .toggleStyle(SwitchToggleStyle(tint: .orange))
                                .padding(.leading, 50)
                                .padding(.trailing, 45)
                                .padding(.top)
//                            Toggle(isOn: $notifications) {
//                                Text("Notifications")
//                                    .foregroundStyle(.white)
//                            }
                        }
                        .scrollBounceBehavior(.basedOnSize)
                        .scrollIndicators(.hidden)
                        .padding(.bottom, 5)
                    }
                    
                }
                
            }
            .frame(width: 345, height: selectedSetting == 8 ? 110 : 50)
            .background{
                Rectangle()
                    .settingsViewColor()
                //                    .frame(width: 352, height: 50)
            }
            .clipShape(.rect(cornerRadius: 35))
        }
        .onChange(of: selectedSetting) { oldValue, newValue in
            withAnimation{
                if newValue == 8 {
                    isChoosingStats = true
                } else{
                    isChoosingStats = false
                }
                
                
                
            }
        }
        .accentColor(.white)
        .preferredColorScheme(.dark)
        
    }
}

#Preview {
    HapticsView(selectedSetting: .constant(8))
}
