//
//  DataManagementView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 5/12/24.
//

import SwiftUI

struct DataManagementView: View {
    @Binding var selectedSetting: Int
//    @State private var selectedSetting = 0 // zmien na 0
    @State private var isChoosingStats = false // zmen na false
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                Group{
                    Button{
                        withAnimation{
                            if selectedSetting == 3{
                                selectedSetting = 0
                            }else{
                                selectedSetting = 3
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
                                .padding(.horizontal ,10)
                                .padding(.vertical, 5)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.white, lineWidth: 2)
                                }
                                .padding(.top,20)
                                .padding(.horizontal, 5)

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
        .onChange(of: selectedSetting) { oldValue, newValue in
            withAnimation{
                if newValue == 3 {
                    isChoosingStats = true
                } else{
                    isChoosingStats = false
                }
                
                
                
            }
        }
        .accentColor(.white)
        .preferredColorScheme(.dark)
        
    }
}

#Preview {
    DataManagementView(selectedSetting: .constant(1))
}


