//
//  HelpAndSupportView.swift
//  MindfulnessApp
//
//  Created by Jakub Kalina on 06/12/2024.
//

import SwiftUI

struct HelpAndSupportView: View {
    @Binding var selectedSetting: Int
//    @State private var selectedSetting = 0 //// zmien na 0
    @State private var isChoosingStats = false // zmen na false
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                Group{
                    Button{
                        withAnimation{
                            if selectedSetting == 7{
                                selectedSetting = 0
                            }else{
                                selectedSetting = 7
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
                            VStack(spacing: 10){
                                Text("Need Help?")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                                   
                                Text("If you encounter any issues or need assistance, please don't hesitate to contact us. We're here to help! Reach out to our support team, and we'll get back to you as soon as possible to resolve any concerns.")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom)
                                    
                                HStack{
                                    Image(systemName: "envelope.fill")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.leading)
                                        
                                    Text("mindflow@gmail.com")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundStyle(.white)
                                        
                                }
                                HStack{
                                    Image(systemName: "phone.fill")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.leading)
                                       
                                    Text("+48 12 123 45 67")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundStyle(.white)
                                       
                                }
                                
                                Text("Thank you for using our app!")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(.top)
                                    
                            }
                            .frame(width:250)
                            
                        }
                        .scrollBounceBehavior(.basedOnSize)
                        .scrollIndicators(.hidden)
                        .padding(.vertical, 10)
                    }
                    
                }
                
            }
            .frame(width: 345, height: selectedSetting == 7 ? 370 : 50)
            .background{
                Rectangle()
                    .settingsViewColor()
                //                    .frame(width: 352, height: 50)
            }
            .clipShape(.rect(cornerRadius: 35))
        }
        .onChange(of: selectedSetting) { oldValue, newValue in
            withAnimation{
                if newValue == 7 {
                    isChoosingStats = true
                } else{
                    isChoosingStats = false
                }
                
                
                
            }
        }
        
    }
}

#Preview {
    HelpAndSupportView(selectedSetting: .constant(7))
}
