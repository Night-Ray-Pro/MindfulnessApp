//
//  AccountAndPrivacyView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 4/12/24.
//

import SwiftUI

struct AccountAndPrivacyView: View {
//    @Binding var selectedSetting: Int
    @State private var username = String()
    @State private var selectedSetting = 0
    @State private var isChoosingStats = false
    var body: some View {
        VStack(spacing:0){
            Group{
                Button{
                    withAnimation{
                        isChoosingStats.toggle()
                        
                        if isChoosingStats{
                            selectedSetting = 1
                        }else{
                            selectedSetting = 0
                        }
                        
                    }
                } label: {
                    Text("Account & Privacy")
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
                if selectedSetting == 1{
                    ScrollView{
//                        Spacer()
                        HStack(spacing:10){
                            Text("Username: ")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                
                                .padding(.leading, 50)
//                            Text("Test")
//                            TextField("Title...", text: $username)
//                                .padding(.bottom, 20)
//                                .multilineTextAlignment(.center)
//                                .foregroundStyle(.white)
//                                .padding(10)
//                                .background(.red.opacity(1.0))
//                                .font(.system(size: 20, weight: .semibold, design: .rounded))
//Spacer()
                            TextField(
                                "",
                                text: $username
                            )
                            
                            .accentColor(.white)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                            .background{
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.gray.opacity(0.3))
                            }
                            .frame(maxWidth:.infinity)
//                            .textFieldStyle(.roundedBorder)
                            .padding(.trailing, 45)
                            
                            
//                            .background(.red)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top,10)
//                        .background(.blue)
                    }
                    .scrollBounceBehavior(.basedOnSize)
                    .scrollIndicators(.hidden)
                    .padding(.bottom, 5)
                }
                
            }
            
        }
        .frame(width: 345, height: selectedSetting == 1 ? 150 : 50)
        .background{
            Rectangle()
                .settingsViewColor()
            //                    .frame(width: 352, height: 50)
        }
        .clipShape(.rect(cornerRadius: 35))
    }
}

#Preview {
    AccountAndPrivacyView(/*selectedSetting: .constant(1)*/)
}
