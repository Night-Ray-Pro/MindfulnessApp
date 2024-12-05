//
//  HomeView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 16/11/24.
//

import SwiftUI
import BottomSheet
import SwiftData

struct HomeView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var hour:Int = Calendar.current.component(.hour, from: .now)
    @State private var mode: Bool = true
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
    
    var currentWeekInterval: String {
        guard let interval = Calendar.current.dateInterval(of: .weekOfMonth, for: Date.now) else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        let startDate = formatter.string(from: interval.start)
        let endDate = formatter.string(from: interval.end)
        return "\(startDate) - \(endDate) \(Calendar.current.component(.year, from: Date.now))"
    }
    
    var currentDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: Date.now)
    }
    
    var currentDayShortName: String {
           let formatter = DateFormatter()
           formatter.dateFormat = "E" // Short form for day of the week
           return formatter.string(from: Date.now)
       }
    
    var body: some View {
        NavigationStack{
            VStack{
                if mode{
                    LightView()
                } else{
                    DarkView()
                }
                
            }
            .toolbarBackground(Color(mode ? "HomeDay":"HomeNight"), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
        .accentColor(.white)
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active {
                withAnimation{
                    setMode()
                    Task{
                        await setUpDailyData()
                    }
                }
                
//                print("Active")
            }
//                        } else if newPhase == .inactive {
//                            print("Inactive")
//                        } else if newPhase == .background {
//                            print("Background")
//                        }
        }
        .onAppear{
//            withAnimation{
                setMode()
//                Task{
//                    await setUpDailyData()
//                }
//            }
//            for week in weeks{
//                modelContext.delete(week)
//                print(weeks.count)
//            }
        }
    }
    
    func setMode(){
//        print("settingMode")
        hour = Calendar.current.component(.hour, from: .now)
        if hour > 5 && hour < 18{
            mode = true
        } else{
            mode = false
        }
    }
    
    func setUpDailyData() async{
        var horoscope = ""
        var prepareRequest: String{
            return "Rewrite this daily horoscope so it is more consise and sounds better and more like a prediction also do not use the horoscope sign name: \(horoscope)"
        }
        let currentWeek = currentWeekInterval
        
        // Check if the week already exists
        if weeks.contains(where: { $0.week == currentWeek }) {
            print("Week already exists")
            
            if weeks.first!.horoscope.isEmpty{
                horoscope = await loadHoroscope()
                let shortHoroscope = await Gemini.fetchResponse(for: prepareRequest)
                weeks.first!.horoscope = shortHoroscope
            }else{
                print( weeks.first!.horoscope)
            }
            
            if weeks.first!.days.contains(where: { $0.dayIdentyfier == currentDay}){
                print("Day in week already exists")
                print(weeks.first!.days.last?.sleep ?? "none")
                if weeks.first!.days.last!.moonPhase.isEmpty{
                    let moonPhase = await loadMoonData()
                    weeks.first!.days.last!.moonPhase = moonPhase
                }
                
                if weeks.first!.days.last!.author.isEmpty || weeks.first!.days.last!.quote.isEmpty{
                    let (quote, author) = await loadQuotesData()
                    weeks.first!.days.last!.quote = quote
                    weeks.first!.days.last!.author = author
                }
                
                return
            }
            
            let moonPhase = await loadMoonData()
            let (quote, author) = await loadQuotesData()
            let newDay = Day(author: author, quote: quote, weekDay: currentDayShortName, dayIdentyfier: currentDay, moonPhase: moonPhase)
            weeks.first!.days.append(newDay)
            print("DayAdded")
            return
        }
        
        // Create and insert new ApplicationData
        horoscope = await loadHoroscope()
        let shortHoroscope = await Gemini.fetchResponse(for: prepareRequest)
        let newWeek = ApplicationData(week: currentWeek, horoscope: shortHoroscope)
        modelContext.insert(newWeek)
        print("New week added: \(currentWeek)")
        
        let moonPhase = await loadMoonData()
        let (quote, author) = await loadQuotesData()
        let newDay = Day(author: author, quote: quote, weekDay: currentDayShortName, dayIdentyfier: currentDay, moonPhase: moonPhase)
        weeks.first!.days.append(newDay)
        print("First Day Added \(currentDay)")
        
        print(weeks.first!.days.last!.quote)
        try? modelContext.save()
    }
    
    func loadMoonData() async -> String{
        let timeStamp = Int(Date().timeIntervalSince1970)
        guard let url = URL(string: "https://api.farmsense.net/v1/moonphases/?d=\(timeStamp)") else { return "Error in API URL" }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            print(timeStamp)
            if let decodedResponse = try? JSONDecoder().decode([moonPhase].self, from: data) {
                return decodedResponse.first?.phase ?? "error"
            }
            return "error in decoding data"
        }catch{
            return error.localizedDescription
        }
        
        
    }
    
    func loadQuotesData() async -> (String, String){
        let timeStamp = Int(Date().timeIntervalSince1970)
        guard let url = URL(string: "https://api.realinspire.tech/v1/quotes/random") else { return ("Error in URL", "Error in URL")}
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            print(timeStamp)
            if let decodedResponse = try? JSONDecoder().decode([dailyQuote].self, from: data) {
                return ((decodedResponse.first?.content ?? "error"), (decodedResponse.first?.author ?? "error" ))
            }
            return("Error in decoding data", "Error in decoding data")
        }catch{
            print(error.localizedDescription)
        }
        return("Error in decoding data", "Error in decoding data")
        
        
    }
    
    func loadHoroscope() async -> String{
        guard let url = URL(string: "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/weekly?sign=\("Sagittarius")") else { return "Error in URL"}
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedData = try? JSONDecoder().decode(Horoscope.self, from: data) {
                return decodedData.data.horoscopeData
            }
        }catch{
            print(error.localizedDescription)
        }
        return "Error in decoding data"
    }
    
    
}

struct LightView: View{
    @State private var position: BottomSheetPosition = .relative(0.51)
    
    var body: some View {
        ZStack{
            //Gradient
            VStack{
                Rectangle()
                    .frame(height:310)
                    .homeDayViewGradient()
                    .ignoresSafeArea()
                Spacer()
            }
            //Graphics
            VStack{
                Spacer()
                
                Image(.homeLightVector)
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 80)
                    
                    
            }
            //Text
            VStack{
                Text("Morning!")
                    .foregroundStyle(.white)
                    .font(.system(size: 48, weight: .semibold, design: .rounded))
                Text("Oskar")
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                Spacer()
            }
            .padding(.top, 60)

        }
        .ignoresSafeArea()
        .bottomSheet(bottomSheetPosition: self.$position, switchablePositions: [
            .relative(0.51),
            .relativeTop(0.975)
        ], headerContent: {
            Text("Dashboard")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding([.horizontal, .bottom])
                .padding(.leading,15)
        })  {
            SheetView()
                .preferredColorScheme(.light)
            //hhhi
        }
//        .dragIndicatorColor(Color(red: 0.17, green: 0.17, blue: 0.33))
        .customBackground(
            Color("homeLightSheet")
                .cornerRadius(30)
//                Image(.homeSheetDayBackground)
//                    .resizable()
//                    .scaledToFit()
        )
        .foregroundColor(.white)
    }
}

struct DarkView: View{
    @State var position: BottomSheetPosition = .relative(0.51)
        
        var body: some View {
            ZStack{
                //Gradient
                VStack{
                    Rectangle()
                        .frame(height:310)
                        .homeNightViewGradient()
                        .ignoresSafeArea()
                    Spacer()
                }
                //Graphics
                VStack{
                    Spacer()
                    
                    Image(.homeDarkVector)
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 80)
                        
                        
                }
                //Text
                VStack{
                    Text("Evening!")
                        .foregroundStyle(.white)
                        .font(.system(size: 48, weight: .semibold, design: .rounded))
                    Text("Oskar")
                        .foregroundStyle(.white)
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                    Spacer()
                }
                .padding(.top, 60)

            }
            .ignoresSafeArea()
            .bottomSheet(bottomSheetPosition: self.$position, switchablePositions: [
                .relative(0.51),
                .relativeTop(0.975)
            ], headerContent: {
                Text("Dashboard")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .padding([.horizontal, .bottom])
                    .padding(.leading,15)
            })  {
                SheetView()
                    .preferredColorScheme(.light)
                //hhhi
            }
    //        .dragIndicatorColor(Color(red: 0.17, green: 0.17, blue: 0.33))
            .customBackground(
                Color("homeDarkSheet")
                    .cornerRadius(30)
//                Image(.homeSheetDayBackground)
//                    .resizable()
//                    .scaledToFit()
            )
            .foregroundColor(.white)
        }
}

#Preview {
    HomeView()
}
