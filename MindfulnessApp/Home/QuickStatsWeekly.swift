//
//  QuickStatsWeekly.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 6/12/24.
//

import SwiftUI
import SwiftData

struct QuickStatsWeekly: View {
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
    var body: some View {
        HStack(spacing:22.5){
            //coffe
            VStack{
                Text("Coffee")
                    .font(.system(size: 14, weight:.bold, design: .rounded))
                Text("\(fetchWeeklyCoffe())")
                    .font(.system(size: 40, weight:.bold, design: .rounded))
                    .minimumScaleFactor(0.5)
                Text("Cups")
                    .font(.system(size: 12, weight:.bold, design: .rounded))
            }
            .padding()
            .frame(width: 100, height: 100)
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
            }
            //meditation
            VStack{
                Text("Meditation")
                    .font(.system(size: 14, weight:.bold, design: .rounded))
                Text("\(fetchWeeklyMeditation())")
                    .font(.system(size: 40, weight:.bold, design: .rounded))
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal)
                Text("Min")
                    .font(.system(size: 12, weight:.bold, design: .rounded))
            }
            .padding(.vertical)
            .frame(width: 100, height: 100)
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
            }
            //journal
            VStack{
                Text("Journal")
                    .font(.system(size: 14, weight:.bold, design: .rounded))
                Text("\(fetchWeeklyEntry())")
                    .font(.system(size: 40, weight:.bold, design: .rounded))
                    .minimumScaleFactor(0.5)
                Text("Entries")
                    .font(.system(size: 12, weight:.bold, design: .rounded))
            }
            .padding()
            .frame(width: 100, height: 100)
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
            }
            
        }
        .foregroundStyle(.white)
    }

    func fetchWeeklyMeditation() -> Int{
        if let week = weeks.first{
            var totalMeditation = 0
            for day in week.days{
                totalMeditation += day.meditation
            }
            return totalMeditation/60
        }
        return 0
    }
    func fetchWeeklyEntry() -> Int{
        if let week = weeks.first{
            var totalEntries = 0
            for day in week.days{
                totalEntries += day.entries
            }
            return totalEntries
        }
        return 0
    }
    
    func fetchWeeklyCoffe() -> Int{
        if let week = weeks.first{
            var totalCoffee = 0
            for day in week.days{
                totalCoffee += day.coffee
            }
            return totalCoffee
        }
        return 0
    }
}

#Preview {
    QuickStatsWeekly()
}
