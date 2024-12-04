//
//  AccountAndSecurityView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 4/12/24.
//

import SwiftUI

struct AccountAndSecurityView: View {
    @State private var isChoosingStats = false
    var body: some View {
        VStack(spacing:0){
            Group{
                Button{
                    withAnimation{
                        isChoosingStats.toggle()
                    }
                } label: {
                    Text("Account and Security")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .padding(.leading)
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
                }
                if isChoosingStats{
                    ScrollView{
                        Text("Content")
                    }
                    .scrollBounceBehavior(.basedOnSize)
                    .scrollIndicators(.hidden)
                    .padding(.bottom, 5)
                }
                
            }
            
        }
        .frame(width: 345, height: isChoosingStats ? 150 : 50)
        .background{
            Rectangle()
                .foregroundStyle(.blue)
                .preferredColorScheme(.light)
            //                    .frame(width: 352, height: 50)
        }
        .clipShape(.rect(cornerRadius: 35))
    }
}

#Preview {
    AccountAndSecurityView()
}
