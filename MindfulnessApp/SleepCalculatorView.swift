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
            VStack{
                Text("Sleep Calculator")
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
