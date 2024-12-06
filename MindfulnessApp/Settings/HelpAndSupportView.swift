//
//  HelpAndSupportView.swift
//  MindfulnessApp
//
//  Created by Jakub Kalina on 06/12/2024.
//

import SwiftUI

struct HelpAndSupportView: View {
    @State private var selectedSetting = 0 // zmien na 0
    @State private var isChoosingStats = false // zmen na false
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                Group{
                    Button{
                        withAnimation{
                            isChoosingStats.toggle()
                            
                            if isChoosingStats{
                                selectedSetting = 7
                            }else{
                                selectedSetting = 0
                            }
                            
                        }
                    } label: {
                        Text("Help & Support")
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
                    if selectedSetting == 7{
                        
                        ScrollView{
                            Text("Need Help?")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .padding(.top, 20)
                            Text("If you encounter any issues or need assistance, please don't hesitate to contact us. We're here to help! Reach out to our support team, and we'll get back to you as soon as possible to resolve any concerns.")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .padding(.leading, 50)
                                .padding(.trailing, 50)
                                .padding(.top, 5)
                            HStack{
                                Image(systemName: "envelope.fill")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 50)
                                    .padding(.top, 5)
                                Text("mindflow@gmail.com")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(.trailing, 50)
                                    .padding(.top, 5)
                            }
                            HStack{
                                Image(systemName: "phone.fill")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 50)
                                    .padding(.top, 5)
                                Text("+48 12 123 45 67")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(.trailing, 50)
                                    .padding(.top, 5)
                            }

                            Text("Thank you for using our app!")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .padding(.top, 10)
                            
                        }
                        .scrollBounceBehavior(.basedOnSize)
                        .scrollIndicators(.hidden)
                        .padding(.bottom, 5)
                    }
                    
                }
                
            }
            .frame(width: 345, height: selectedSetting == 7 ? 375 : 50)
            .background{
                Rectangle()
                    .settingsViewColor()
                //                    .frame(width: 352, height: 50)
            }
            .clipShape(.rect(cornerRadius: 35))
        }
    }
}

#Preview {
    HelpAndSupportView()
}