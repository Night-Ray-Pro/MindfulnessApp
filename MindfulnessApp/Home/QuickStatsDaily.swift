//
//  QuickStatsDaily.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 6/12/24.
//

import SwiftUI
import SwiftData

struct QuickStatsDaily: View {
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
    var body: some View {
        HStack(spacing:22.5){
            //coffe
            VStack{
                Text("Coffee")
                    .font(.system(size: 14, weight:.bold, design: .rounded))
                Text("\(fetchDailyCoffe())")
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
                Text("\(fetchDailyMeditation())")
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
                Text("\(fetchDailyEntry())")
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
   
    func fetchDailyMeditation() -> Int{
        if let week = weeks.first{
            if let day = week.days.last{
                return day.meditation/60
            }
        }
        return 0
    }
    func fetchDailyEntry() -> Int{
        if let week = weeks.first{
            if let day = week.days.last{
                return day.entries
            }
        }
        return 0
    }
    
    func fetchDailyCoffe() -> Int{
        if let week = weeks.first{
            if let day = week.days.last{
                return day.coffee
            }
        }
        return 0
    }
}

#Preview {
    QuickStatsDaily()
}
