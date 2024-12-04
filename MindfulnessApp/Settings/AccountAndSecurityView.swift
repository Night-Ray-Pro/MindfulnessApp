//
//  AccountAndSecurityView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 4/12/24.
//

import SwiftUI

struct AccountAndSecurityView: View {
//    @Binding var selectedSetting: Int
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
                    Text("Account & Security")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
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
                        Text("Content")
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
                .foregroundStyle(.blue)
                .preferredColorScheme(.light)
            //                    .frame(width: 352, height: 50)
        }
        .clipShape(.rect(cornerRadius: 35))
    }
}

#Preview {
    AccountAndSecurityView(/*selectedSetting: .constant(1)*/)
}
