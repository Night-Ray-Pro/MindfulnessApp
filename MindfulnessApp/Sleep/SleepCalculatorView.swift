//
//  SleepCalculatorView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI
import CoreML
import SwiftData

struct SleepCalculatorView: View {
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
    @AppStorage("wakeUp") private var wakeUp = averageDate
    @AppStorage("sleepAmount") private var sleepAmount = 8.0
    @AppStorage("coffeAmount") private var coffeAmount = 1
    
    @State private var alertTitle = "Your ideal bed time is:"
    @AppStorage("calculatedSleepTime") private var alertMessage = "Calculating ..."
    @State private var alertShow = false
    @AppStorage("haptics") var haptics = false
    let isCalculated = false
    
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
                            .frame(width: 352, height: 293)
                        if let week = weeks.first{
                            //
                            
                            if week.days.last!.sleep == 0{
                                VStack{
                                    
                                    DatePicker(selection: $wakeUp, displayedComponents: [.hourAndMinute]) {
                                        Text("Wake up time")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 22, weight: .bold, design: .rounded))
                                        
                                    }
                                    .disabled(isCalculated)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .accentColor(.white.opacity(0.5))
                                    .environment(\.colorScheme, .dark)
                                    
                                    Rectangle()
                                        .foregroundStyle(.white.opacity(0.8))
                                        .frame(width: 298, height: 1)
                                    //                                .padding()
                                    
                                    Text("Desired ammount of sleep")
                                        .foregroundStyle(.white.opacity(0.6))
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
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
                                            .font(.system(size: 22, weight: .bold, design: .rounded))
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
                                    Text("Cups of coffee")
                                        .foregroundStyle(.white.opacity(0.6))
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    HStack{
                                        Button{
                                            coffeAmount -= 1
                                        } label: {
                                            Image(systemName: "minus")
                                                .resizable()
                                                .foregroundStyle(.white)
                                                .scaledToFit()
                                                .frame(width: 20, height: 20)
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
                                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                            
                                            
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
                                    ZStack{
                                        Image(.clockVector)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 260, height: 180)
                                            .offset(y:-5)
                                        
                                        
                                        //
                                        Text(alertMessage)
                                            .foregroundStyle(.white)
                                            .font(Font.custom("alarmClock", size: 60))
                                        //                                        .font(.system(size: 60, weight: .bold, design: .rounded))
                                        
                                    }
                                    
                                    Spacer()
                                }
                                .padding()
                                .padding(.top,10)
                            }
                            
                        }
                        
                        
                    }
                    .frame(width: 352, height: 293)
                    .padding(.top, 22.0)
//                    .padding(.bottom, 35.0)
                    
                   
                        Button{
                            calculateBedTime()
                            withAnimation{
//                                isCalculated.toggle()
                            }
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.ultraThinMaterial)
                                
                                    .preferredColorScheme(.light)
                                if let week = weeks.first{
                                    if week.days.last!.sleep == 0{
                                        Text("Calculate")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 24, weight: .bold, design: .rounded))
                                    }else{
                                        Text("Recalculate")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 24, weight: .bold, design: .rounded))
                                    }
                                }
                             
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
        .sensoryFeedback(haptics ? .selection : .alignment, trigger: coffeAmount)
        .sensoryFeedback(haptics ? .selection : .alignment, trigger: sleepAmount)
        .sensoryFeedback(haptics ? .selection : .alignment, trigger: wakeUp)
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
        
        
            if let week = weeks.first{
                if  week.days.last!.sleep == 0{
                    week.days.last!.sleep = Int(sleepAmount)
                    week.days.last!.coffee = Int(coffeAmount)
                }else{
                    week.days.last!.sleep = 0
                    week.days.last!.coffee = 0
                }
                
            }
       
    }
}

#Preview {
    SleepCalculatorView()
}
