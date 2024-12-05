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
    @State private var gender = String()
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
                        HStack(spacing:10){
                            Text("Username: ")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                .padding(.leading, 50)

                            TextField(
                                "",
                                text: $username
                            )
                            .multilineTextAlignment(.center)
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
                        
                        HStack(spacing:10){
//                            Text("Gender: ")
//                                .font(.system(size: 16, weight: .medium, design: .rounded))
//                                .foregroundStyle(.white)
//                                .padding(.leading, 50)
//                                .frame(maxWidth: 100)
                            
                            Button(action: {
                                    gender = "Woman"
                                }) {
                                    Text("Woman")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(gender == "Woman" ? .white : .gray.opacity(0.3))
                                        .padding()
                                        .frame(maxWidth: 100)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(gender == "Woman" ? Color.white : Color.gray.opacity(0.3), lineWidth: 2)
                                        )
                            }

                            Button(action: {
                                    gender = "Man"
                                }) {
                                    Text("Man")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(gender == "Man" ? .white : .gray.opacity(0.3))
                                        .padding()
                                        .frame(maxWidth: 100)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(gender == "Man" ? Color.white : Color.gray.opacity(0.3), lineWidth: 2)
                                        )
                            }
//                            .frame(maxWidth: .infinity)
                            .padding(.trailing, 45)
                            
                        }
//                        .frame(maxWidth: .infinity, maxHeight: 18, alignment: .leading)
                        .padding(.top,10)
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
