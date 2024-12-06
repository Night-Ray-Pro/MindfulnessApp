//
//  FeedbackView.swift
//  MindfulnessApp
//
//  Created by Jakub Kalina on 05/12/2024.
//

import SwiftUI
import StoreKit

struct FeedbackView: View {
    @State private var selectedSetting = 0 // zmien na 0
    @State private var isChoosingStats = false // zmen na false
    @Environment(\.requestReview) var requestReview
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                Group{
                    Button{
                        withAnimation{
                            isChoosingStats.toggle()
                            
                            if isChoosingStats{
                                selectedSetting = 6
                            }else{
                                selectedSetting = 0
                            }
                            
                        }
                    } label: {
                        Text("Feedback")
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
                    if selectedSetting == 6{
                        
                        ScrollView{
                            Button{
                                requestReview()
                            } label: {
                                Text("Review MindFlow App")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 5)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.white, lineWidth: 2)
                                    }
                                    .padding(.top, 15)
                                    .padding(.horizontal)
                            }
                        }
                        .scrollBounceBehavior(.basedOnSize)
                        .scrollIndicators(.hidden)
                        .padding(.bottom, 5)
                    }
                    
                }
                
            }
            .frame(width: 345, height: selectedSetting == 6 ? 110 : 50)
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
    FeedbackView()
}
