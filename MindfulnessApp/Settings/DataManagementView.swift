//
//  DataManagementView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 5/12/24.
//

import SwiftUI

struct DataManagementView: View {
    @State private var selectedSetting = 3 // zmien na 0
    @State private var isChoosingStats = true // zmen na false
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                Group{
                    Button{
                        withAnimation{
                            isChoosingStats.toggle()
                            
                            if isChoosingStats{
                                selectedSetting = 3
                            }else{
                                selectedSetting = 0
                            }
                            
                        }
                    } label: {
                        Text("Data Management")
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
                    if selectedSetting == 3{
                        
                        ScrollView{
                        
                            NavigationLink{
                                DataView()
                                .toolbarBackground(.black.opacity(0.4), for: .navigationBar)
                                .toolbarBackground(.visible, for: .navigationBar)
                            } label:{
                                HStack{
                                    Text("Collected Data")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                       
                              Spacer()
                                    Image(systemName: "chevron.forward")
                                      
                                        .foregroundStyle(.white)
                                }
                                .frame(width:240)
                                .padding(.horizontal ,15)
                                .padding(.vertical, 5)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.white, lineWidth: 2)
                                }
                                .padding(.top,20)

                            }
                            
                            Button{
                                /// add functionality later
                            } label: {
                                Text("Clear Data")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 5)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.white, lineWidth: 2)
                                    }
                                    .padding(.top, 10)
                            }
                            
                            
                            
                        }
                        .scrollBounceBehavior(.basedOnSize)
                        .scrollIndicators(.hidden)
                        .padding(.bottom, 5)
                    }
                    
                }
                
            }
            .frame(width: 345, height: selectedSetting == 3 ? 165 : 50)
            .background{
                Rectangle()
                    .settingsViewColor()
                //                    .frame(width: 352, height: 50)
            }
            .clipShape(.rect(cornerRadius: 35))
        }
        .accentColor(.white)
        .preferredColorScheme(.dark)
        
    }
}

#Preview {
    DataManagementView()
}
