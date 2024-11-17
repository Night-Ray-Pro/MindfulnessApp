//
//  NotesView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI

struct NotesView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Image(.journalVector)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                VStack{
                    HStack{
                        
                        Button {
                            //
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.white)
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            //
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.white)
                               
                        }
                        
                    }
                    .padding(.top, 35)
                    .padding(.bottom, 5)
                    .padding(.horizontal,20)
                    Text("Oskar's Journal")
                        .font(.custom("SignPainter", size: 60))
                        .foregroundStyle(.white)

                    
                    Text("I’m creating the life of my dreams.")
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundStyle(.white)
                        .padding(.top, 2)
                        .padding(.bottom, 10)
                        
                    
                    Image(.journalVector3)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 352, height: 50)
                        .foregroundStyle(.ultraThinMaterial)
                    

                    
                    ScrollView{
                        
                        ForEach(1..<10){ num in
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 352, height: 293)
                                .foregroundStyle(.ultraThinMaterial)
                                .padding(.bottom, 30)
                            
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
                VStack{
                    Spacer()
                    Image(.journalVector2)
                        
                }
                .ignoresSafeArea()
            }
            .toolbarBackground(Color("Notes"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    NotesView()
}
