//
//  AccountAndPrivacyView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 4/12/24.
//

import SwiftUI

struct AccountAndPrivacyView: View {
    //    @Binding var selectedSetting: Int
    @State private var username = String()
    @State private var gender = String()
    @State private var date_of_birth = Date()
    @State private var height = Int()
    @State private var weight = Int()
    @State private var selectedSetting = 1 // zmien na 0
    @State private var isChoosingStats = true // zmen na false
    @FocusState private var nameIsFocusedHeight: Bool
    @FocusState private var nameIsFocusedWeight: Bool
    var body: some View {
        NavigationStack{
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
                        Text("Account & Privacy")
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
                    if selectedSetting == 1{
                        ScrollView{
                            HStack(spacing:10){
                                Text("Username:")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(.leading, 50)
                                
                                TextField(
                                    "",
                                    text: $username
                                )
                                .multilineTextAlignment(.center)
                                .accentColor(.white)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                .background{
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(.gray.opacity(0.3))
                                }
                                .frame(maxWidth:.infinity)
                                //                            .textFieldStyle(.roundedBorder)
                                .padding(.trailing, 45)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top,15)
                            
                            HStack(spacing:10){
                                Text("Gender:")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(.leading, 50)
                                
                                Spacer()
                                Button(action: {
                                    withAnimation{
                                        gender = "Woman"
                                    }
                                }) {
                                    Text("Woman")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(gender == "Woman" ? .white : .gray.opacity(0.3))
                                        .frame(width: 70, height: 25)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(gender == "Woman" ? Color.white : Color.gray.opacity(0.3), lineWidth: 2)
                                        )
                                        .padding(.trailing, 5)
                                }
                                
                                Button(action: {
                                    withAnimation{
                                        gender = "Man"
                                    }
                                }) {
                                    Text("Man")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(gender == "Man" ? .white : .gray.opacity(0.3))
                                        .frame(width: 70, height: 25)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(gender == "Man" ? Color.white : Color.gray.opacity(0.3), lineWidth: 2)
                                        )
                                        .padding(.trailing, 45)
                                }
                            }
                            .padding(.top,10)
                            
                            HStack(spacing:10){
                                Text("Date of birth:")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(.leading, 50)
                                
                                Spacer()
                                HStack{
                                    Text(date_of_birth.formatted(.dateTime.day().month().year()))
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(.white)
                                    
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:5)
                                    //                                    .font(.system(size: 9, weight: .bold))
                                        .foregroundStyle(.white)
                                }
                                .frame(width: 120, height: 25)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.white, lineWidth: 2)
                                )
                                .padding(.trailing, 45)
                                .overlay {
                                    DatePicker(selection: $date_of_birth, displayedComponents: .date) {}
                                        .labelsHidden()
                                        .colorMultiply(.clear)       // <<< here
                                        .accentColor(.black.opacity(0.5))
                                    
                                }
                                
                            }
                            .padding(.top,10)
                            
                            HStack(spacing:10){
                                Text("Height:")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(.leading, 50)
                                Spacer()
                                TextField(
                                    "",
                                    value: $height, format: .number)
                                .focused($nameIsFocusedHeight)
                                .keyboardType(.numberPad)
                                
                                .multilineTextAlignment(.trailing)
                                .accentColor(.white)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                .background{
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(.gray.opacity(0.3))
                                }
                                .frame(width: 50)
                                //                            .textFieldStyle(.roundedBorder)
                                
                                Text("cm")
                                    .frame(width:25)
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(.trailing, 45)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top,10)
                            
                            HStack(spacing:10){
                                Text("Weight:")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(.leading, 50)
                                Spacer()
                                TextField(
                                    "",
                                    value: $weight, format: .number)
                                .focused($nameIsFocusedWeight)
                                .keyboardType(.numberPad)
                                
                                .multilineTextAlignment(.trailing)
                                .accentColor(.white)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                .background{
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(.gray.opacity(0.3))
                                }
                                .frame(width: 50)
                                //                            .textFieldStyle(.roundedBorder)
                                
                                Text("kg")
                                    .frame(width:25)
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(.trailing, 45)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top,10)
                            
                        }
                        .scrollBounceBehavior(.basedOnSize)
                        .scrollIndicators(.hidden)
                        .padding(.bottom, 5)
                    }
                    
                }
                
            }
            .onTapGesture {
//                print("Tapped")
                nameIsFocusedHeight = false
                nameIsFocusedWeight = false
            }
            .frame(width: 345, height: selectedSetting == 1 ? 275 : 50)
            .background{
                Rectangle()
                    .settingsViewColor()
                //                    .frame(width: 352, height: 50)
            }
            .clipShape(.rect(cornerRadius: 35))
        }
    }
}

#Preview {
    AccountAndPrivacyView(/*selectedSetting: .constant(1)*/)
}
