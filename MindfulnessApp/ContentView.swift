//
//  ContentView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 14/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "1.circle")
                .resizable()
                .frame(width: 100,height: 100)
                .foregroundStyle(.red)
            Text("TestVersion 1.0")
                .font(.title3)
                .fontWeight(.bold)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
