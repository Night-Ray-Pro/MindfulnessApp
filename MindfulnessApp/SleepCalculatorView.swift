//
//  SleepCalculatorView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI

struct SleepCalculatorView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                //back gradient
                VStack{
                    Rectangle()
                        .calculatorViewGradient()
                        .ignoresSafeArea()
                }
                //SVG image
                VStack{
                    Image(.sleepCalculatorVector)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .shadow(radius: 22)
                    
                    Spacer()
                }
                //Controls
                VStack{

                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 352, height: 293)
                        .foregroundStyle(.ultraThinMaterial)
                        .padding(.top, 22.0)
                        .preferredColorScheme(.light)

                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 195, height: 58)
                        .foregroundStyle(.ultraThinMaterial)
                        .padding(.top, 22.0)
                        .padding(.bottom, 35.0)
                        .preferredColorScheme(.light)
                }

                
            }
            .toolbarBackground(Color("Calculator"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    SleepCalculatorView()
}
