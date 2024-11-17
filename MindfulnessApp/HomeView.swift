//
//  HomeView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI
import BottomSheet

struct HomeView: View {
    @State private var hour:Int = Calendar.current.component(.hour, from: .now)
    var body: some View {
        NavigationStack{
            VStack{
                if hour > 5 && hour < 18{
                    LightView()
                } else{
                    DarkView()
                }
                
            }
            .toolbarBackground(Color("HomeDay"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

struct LightView: View{
    var body: some View {
        Image(.homeLightVector)
            .resizable()
            .ignoresSafeArea()
    }
}

struct DarkView: View{
    var body: some View {
        Text("Dark")
    }
}

#Preview {
    HomeView()
}
