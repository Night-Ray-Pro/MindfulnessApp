//
//  SheetView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 2/12/24.
//

import SwiftUI
import Charts

struct SheetView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [JournalEntry]()
    @State private var tabbarVisibility = Visibility.visible
    @State private var opacity = 1.0
    @State private var phase = String()
    @State private var quote = String()
    @State private var quoteAuthor = String()
    @State private var sign = "Sagittarius"
    @State private var moonDescription = false
    @State private var horoscope = String() {
        willSet{
            Task{
                shortHoroscope = await Gemini.fetchResponse(for: prepareRequest)
            }
        }
    }
    @State private var shortHoroscope: String?
    let testText = "This is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test textThis is a test text"
    let testData = [10,7,3]
    var prepareRequest: String{
        return "Rewrite this daily horoscope so it is more consise and sounds better and more like a prediction also do not use the horoscope sign name: \(horoscope)"
    }
    var body: some View {
        NavigationStack(path: $path){
            ScrollView{
                
                //                Image(.homeSheetDayBackground)
                //                    .resizable()
                //                    .ignoresSafeArea()
                
                VStack{
                    
                    //Daily quote
                    VStack(spacing:0){
                        Text(quoteAuthor)
                        //                            .foregroundStyle(.black.opacity(0.2))
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .padding([.horizontal, .vertical], 10)
                            .frame(width: 345, alignment: .leading)
                        //                            .background(.blue)
                        
                        Text(quote)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                        //                            .background(.blue)
                            .minimumScaleFactor(0.4)
                            .padding([.horizontal, .bottom],10)
                            .frame(width: 345, height: 120, alignment: .center)
                        //                            .background(.green)
                        
                        //                    Text(quote)
                        //                        .padding()
                        //                    if !horoscope.isEmpty{
                        //                        TestView(inputString: horoscope)
                        //                    }
                        //                    Image(systemName: phase)
                        //                    Text(phase)
                    }
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                    }
                    
                    //Quick acces buttons
                    HStack{
                        Button{
                            let newNote = JournalEntry()
                            modelContext.insert(newNote)
                            path = [newNote]
                        } label: {
                            HStack(spacing: 10){
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                    .foregroundStyle(.white)
                                Text("Quick Note")
                                    .frame(width:85)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                            }
                            .frame(width: 170, height: 70)
                            .background{
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.ultraThinMaterial)
                            }
                        }
                        
                        
                        NavigationLink{
                            MusicPlayerView(length: 5, theme: "relax")
                                .accentColor(.white)
                                .onAppear {
                                        tabbarVisibility = .hidden
                                        opacity = 0.0
                                }
                                .onDisappear{
                                        tabbarVisibility = .visible
                                    opacity = 1.0
                                }
                                
                        } label: {
                            HStack(spacing: 10){
                                Image(systemName: "leaf")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 35)
                                    .foregroundStyle(.white)
                                Text("Quick Rest")
                                    .frame(width:85)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                            }
                            .frame(width: 170, height: 70)
                            .background{
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.ultraThinMaterial)
                            }
                        }
                        
                        
                    }
                    
                    //Sleep chart
                    VStack{
                        HStack(alignment:.top){
                            Text("Sleep this week")
                                .foregroundStyle(.white)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            Spacer()
                            Text(testData.reduce(0, +).formatted(.number) + "h")
                                .foregroundStyle(.white)
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                        }
                        .padding()
                        .frame(width: 345)
                        
                        
                        Chart(testData, id: \.self) { data in
                            
                            BarMark(
                                x: .value("Views", data)
                            )
                            .foregroundStyle(.white)
                            
                        }
                        .chartXScale(domain: 0...30)
                        .chartPlotStyle { plotArea in
                            plotArea
                                .background(Color(.systemFill))
                                .cornerRadius(10)
                        }
                        .chartXAxis(.hidden)
                        .frame(width: 310, height: 12)
                    }
                    .padding(.bottom,15)
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                    }
                    
                    //Moon and sign
                    HStack{
                        Button{
                            withAnimation{
                                moonDescription.toggle()
                            }
                        } label: {
                            VStack(spacing:15){
                                Text(moonDescription ? phase : "Moon Phase")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                                    .minimumScaleFactor(0.5)
                                    .frame(width:85)
                                
                                Image(systemName: "moonphase." + (phase.lowercased().replacingOccurrences(of: " ", with: ".")))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 42)
                                    .foregroundStyle(.white)
                            }
                            .padding()
                            .frame(height: moonDescription ? 120 : 110)
                            .background{
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.ultraThinMaterial)
                            }
                        }
                        
                        VStack(spacing:15){
                            HStack{
                                Text("Your sign")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                Spacer()
                            }
                            HStack{
                                Image("\(sign)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 55, height: 42)
                                
                                Text(sign)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                            }
                        }
                        .padding()
                        .frame(height: moonDescription ? 120 : 110)
                        .background{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThinMaterial)
                        }
                    }
                    .frame(width: 345)
                    
                    //Weekly horoscope
                    VStack(spacing:0){
                        Text("Weekly horoscope")
                            .foregroundStyle(.white)
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .padding([.horizontal, .vertical], 10)
                            .frame(width: 345, alignment: .leading)
                        
                        if let shortHoroscope{
                            Text(shortHoroscope)
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.4)
                                .padding([.horizontal, .bottom],10)
                                .frame(width: 345, height: 190, alignment: .center)
                        }
                    }
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                    }
                    
                    
                    
                    Spacer()
                }
                .padding(.bottom, 100)
                .padding(.top, 5)
                //                .background(.red)
                .onAppear {
                    Task{
                        await loadMoonData()
                        await loadQuotesData()
                        await loadHoroscope()
                    }
                }
                
            }
            .navigationDestination(for: JournalEntry.self){ entry in
                EditNoteView(note: entry)
                    .toolbarBackground(Color(red: 146 / 255, green: 128 / 255, blue: 193 / 255), for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                
                    .onAppear {
                        tabbarVisibility = .hidden
                        opacity = 0.0
                    }
                    .onDisappear{
                        tabbarVisibility = .visible
                        opacity = 1.0
                    }
            
            }
            .scrollIndicators(.hidden)
//            .padding(.bottom, 50)
//            .toolbarBackground(.visible, for: .tabBar)
            
            //        .background(.yellow)
        }
        .toolbar(tabbarVisibility, for: .tabBar)
        .animation(.easeInOut(duration:0.2), value: tabbarVisibility)
        .accentColor(.white)
        
    }
    func loadMoonData() async{
        let timeStamp = Int(Date().timeIntervalSince1970)
        guard let url = URL(string: "https://api.farmsense.net/v1/moonphases/?d=\(timeStamp)") else { return }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            print(timeStamp)
            if let decodedResponse = try? JSONDecoder().decode([moonPhase].self, from: data) {
                phase = decodedResponse.first?.phase ?? "error"
            }
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
    
    func loadQuotesData() async{
        let timeStamp = Int(Date().timeIntervalSince1970)
        guard let url = URL(string: "https://api.realinspire.tech/v1/quotes/random") else { return }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            print(timeStamp)
            if let decodedResponse = try? JSONDecoder().decode([dailyQuote].self, from: data) {
                quote = decodedResponse.first?.content ?? "error"
                quoteAuthor = decodedResponse.first?.author ?? "error"
            }
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
    
    func loadHoroscope() async{
        guard let url = URL(string: "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/weekly?sign=\(sign)") else { return }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedData = try? JSONDecoder().decode(Horoscope.self, from: data) {
                horoscope = decodedData.data.horoscopeData
            }
        }catch{
            print(error.localizedDescription)
        }
        
    }
}

#Preview {
    SheetView()
}
