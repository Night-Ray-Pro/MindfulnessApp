//
//  SleepCalculatorView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI
import CoreML

struct SleepCalculatorView: View {
    @State private var wakeUp = averageDate
    @State private var sleepAmount = 8.0
    @State private var coffeAmount = 1
    
    @State private var alertTitle = "Your ideal bed time is:"
    @State private var alertMessage = "Calculating ..."
    @State private var alertShow = false
    @State private var isCalculated = false
    
    static var averageDate:Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
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
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.ultraThinMaterial)
                            .preferredColorScheme(.light)
                        if !isCalculated{
                            VStack{
                                
                                DatePicker(selection: $wakeUp, displayedComponents: [.hourAndMinute]) {
                                    Text("Wake up time")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 20, weight: .regular, design: .rounded))
                                }
                                .disabled(isCalculated)
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .accentColor(.white.opacity(0.5))
                                .environment(\.colorScheme, .dark)
                                
                                Rectangle()
                                    .foregroundStyle(.white.opacity(0.8))
                                    .frame(width: 298, height: 1)
                                //                                .padding()
                                
                                Text("DESIRED AMMOUNT OF SLEEP")
                                    .foregroundStyle(.white.opacity(0.6))
                                    .font(.system(size: 16, weight: .light, design: .rounded))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    Button{
                                        sleepAmount -= 1
                                    } label: {
                                        Image(systemName: "minus")
                                            .resizable()
                                            .foregroundStyle(.white)
                                            .scaledToFit()
                                            .frame(width: 16, height: 16)
                                            .padding(.horizontal,10)
                                            .padding(.vertical, 6)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.white, lineWidth: 1)
                                            }
                                        
                                    }
                                    .disabled(isCalculated)
                                    
                                    Spacer()
                                    Text("\(Int(sleepAmount)) hours")
                                        .font(.system(size: 20, weight: .regular, design: .rounded))
                                        .foregroundStyle(.white)
                                    Spacer()
                                    
                                    Button{
                                        sleepAmount += 1
                                    } label: {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .foregroundStyle(.white)
                                            .scaledToFit()
                                            .frame(width: 16, height: 16)
                                            .padding(.horizontal,10)
                                            .padding(.vertical, 6)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.white, lineWidth: 1)
                                            }
                                        
                                    }
                                    .disabled(isCalculated)
                                }
                                .padding()
                                
                                Rectangle()
                                    .foregroundStyle(.white.opacity(0.8))
                                    .frame(width: 298, height: 1)
                                //                                .padding()
                                Text("CUPS OF COFFEE")
                                    .foregroundStyle(.white.opacity(0.6))
                                    .font(.system(size: 16, weight: .light, design: .rounded))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    Button{
                                        coffeAmount -= 1
                                    } label: {
                                        Image(systemName: "minus")
                                            .resizable()
                                            .foregroundStyle(.white)
                                            .scaledToFit()
                                            .frame(width: 16, height: 16)
                                            .padding(.horizontal,10)
                                            .padding(.vertical, 6)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.white, lineWidth: 1)
                                            }
                                        
                                    }
                                    .disabled(isCalculated)
                                    
                                    Spacer()
                                    Group{
                                        Text("\(coffeAmount)")
                                        
                                        
                                        Image(systemName: "cup.and.saucer")
                                        
                                    }
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                    .foregroundStyle(.white)
                                    Spacer()
                                    
                                    Button{
                                        coffeAmount += 1
                                    } label: {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .foregroundStyle(.white)
                                            .scaledToFit()
                                            .frame(width: 16, height: 16)
                                            .padding(.horizontal,10)
                                            .padding(.vertical, 6)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.white, lineWidth: 1)
                                            }
                                        
                                    }
                                    .disabled(isCalculated)
                                }
                                .padding()
                                
                                //                            if isCalculated{
                                //                                Rectangle()
                                //                                    .foregroundStyle(.white.opacity(0.8))
                                //                                    .frame(width: 298, height: 1)
                                //                                Text(alertMessage)
                                //                                    .foregroundStyle(.white)
                                //                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                //                                    .padding(.top, 10)
                                //                                Button{
                                //                                    withAnimation{
                                //                                        isCalculated.toggle()
                                //                                    }
                                //                                } label: {
                                //                                    Text("Recalculate")
                                //                                        .foregroundStyle(.white)
                                //                                        .font(.system(size: 24, weight: .bold, design: .rounded))
                                //                                        .padding(.vertical, 13)
                                //                                        .padding(.horizontal, 30)
                                //                                        .overlay {
                                //                                            RoundedRectangle(cornerRadius: 20)
                                //                                                .stroke(.white, lineWidth: 1)
                                //                                        }
                                //                                }
                                //                                .padding(.bottom, 5)
                                //                            }
                                
                            }
                            .padding()
                        }else{
                            VStack{
                                Text("Your ideal sleep time is:")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                Rectangle()
                                    .foregroundStyle(.white.opacity(0.8))
                                    .frame(width: 298, height: 1)
                                Spacer()
                                Text(alertMessage)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 60, weight: .bold, design: .rounded))
                                Spacer()
                            }
                            .padding()
                            .padding(.top,10)
                        }
                    }
                    .frame(width: 352, height: 293)
                    .padding(.top, 22.0)
//                    .padding(.bottom, 35.0)
                    
                   
                        Button{
                            calculateBedTime()
                            withAnimation{
                                isCalculated.toggle()
                            }
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.ultraThinMaterial)
                                
                                    .preferredColorScheme(.light)
                                Text(isCalculated ? "Recalculate" : "Calculate")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                            }
                            .frame(width: 195, height: 58)
                            .padding(.top, 22.0)
                            .padding(.bottom, 30.0)
                        }
                        .transition(.scale)
                    
                }
                
                
            }
            .toolbarBackground(Color("Calculator"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
    
    func calculateBedTime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (dateComponents.hour ?? 0)*3600
            let minute = (dateComponents.minute ?? 0)*60
            
            let predictions = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
            let sleepTime = wakeUp - predictions.actualSleep
            
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }catch{
            alertTitle = "Sorry something went wrong."
            alertMessage = "There was a problem calculating your bed time"
        }
        alertShow.toggle()
    }
}

#Preview {
    SleepCalculatorView()
}
