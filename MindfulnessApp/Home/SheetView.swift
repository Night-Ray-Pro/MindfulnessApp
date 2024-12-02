//
//  SheetView.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 2/12/24.
//

import SwiftUI

struct SheetView: View {
    @State private var phase = String()
    @State private var quote = String()
    @State private var sign = "Sagittarius"
    @State private var horoscope = String()
    var body: some View {
        ScrollView{
            ZStack{
//                Image(.homeSheetDayBackground)
//                    .resizable()
//                    .ignoresSafeArea()

                VStack{
                    Text(quote)
                        .padding()
                    if !horoscope.isEmpty{
                        TestView(inputString: horoscope)
                    }
                    Image(systemName: phase)
                    Text(phase)
                        .onAppear {
                            Task{
                                await loadMoonData()
                                await loadQuotesData()
                                await loadHoroscope()
                            }
                        }
                    Spacer()
                }
//                .background(.red)
            }
        }
    }
    func loadMoonData() async{
        let timeStamp = Int(Date().timeIntervalSince1970)
        guard let url = URL(string: "https://api.farmsense.net/v1/moonphases/?d=\(timeStamp)") else { return }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            print(timeStamp)
            if let decodedResponse = try? JSONDecoder().decode([moonPhase].self, from: data) {
                phase = "moonphase." + (decodedResponse.first?.phase.lowercased().replacingOccurrences(of: " ", with: ".") ?? "error")
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
            }
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
    
    func loadHoroscope() async{
        guard let url = URL(string: "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/daily?sign=\(sign)&day=TODAY") else { return }
        
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
