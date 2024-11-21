//
//  AddNoteView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 19/11/24.
//

import SwiftUI

struct AddNoteView: View {
    @State private var text = String()
    var body: some View {
        
        ZStack{
            Rectangle()
                .addNoteGradient()
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    Spacer()
                    Image(systemName: "trash")
                        .resizable()
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 20)
                }
                .padding(.horizontal)
                .padding(.top, 65)
//                .ignoresSafeArea()
//                .padding(.top,5)

                HStack{
                    VStack(alignment: .center){
                        Text(Date.now, style: .date)
                            .foregroundStyle(.white)
                        Text("Title")
                            .font(.custom("Courier", size: 60))
                            .foregroundStyle(.white)
                        Text("Add Location ...")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.ultraThinMaterial)
                }
                .frame(height: 100)
                .padding()
                ZStack{
//                    RoundedRectangle(cornerRadius: 20)
//                        .foregroundStyle(.ultraThinMaterial)
//                        .padding()
                        
                    TextEditor(text: $text)
                        .scrollContentBackground(.hidden)
                        .padding(5)
                        .background(.ultraThinMaterial)
                        .foregroundStyle(.white)
                }
//                .frame(height: 550)
                .clipShape(.rect(cornerRadius: 20))
                .padding()
                
                Spacer()
            }
            .ignoresSafeArea()
            
        }
        .navigationTitle("test")

        .toolbar{
            Button{
                //
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
            }
        }
        
    }
}

#Preview {
    AddNoteView()
}
