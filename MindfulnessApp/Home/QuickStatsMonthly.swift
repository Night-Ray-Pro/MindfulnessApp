//
//  QuickStatsMonthly.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 6/12/24.
//

import SwiftUI
import SwiftData

struct QuickStatsMonthly: View {
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
    
    var currentWeekInterval: String {
        guard let interval = Calendar.current.dateInterval(of: .weekOfMonth, for: Date.now) else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        let startDate = formatter.string(from: interval.start)
        let endDate = formatter.string(from: interval.end)
        return "\(startDate) - \(endDate) \(Calendar.current.component(.year, from: Date.now))"
    }

    var body: some View {
        HStack(spacing:22.5){
            //coffe
            VStack{
                Text("Coffee")
                    .font(.system(size: 14, weight:.bold, design: .rounded))
                Text("\(fetchMonthlyCoffe())")
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
                Text("\(fetchMonthlyMeditation())")
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
                Text("\(fetchMonthlyEntries())")
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
//        .onAppear{
//            let test = currentWeekInterval
//            let r = test.index(test.startIndex, offsetBy: 3) ..< test.index(test.startIndex, offsetBy: 5)
//            print(currentWeekInterval[r])
//        }
    }

    func fetchMonthlyMeditation() -> Int{
        
        let currentWeekString = currentWeekInterval
        let range = currentWeekString.index(currentWeekString.startIndex, offsetBy: 3) ..< currentWeekString.index(currentWeekString.startIndex, offsetBy: 5)
        let weeksThisMonth = weeks.filter({ $0.week[range] == currentWeekInterval[range]})
        var totalMeditation = 0
        for week in weeksThisMonth{
            for day in week.days{
                totalMeditation += day.meditation
            }
        }
        
        return totalMeditation/60
    }
    func fetchMonthlyEntries() -> Int{
        
        let currentWeekString = currentWeekInterval
        let range = currentWeekString.index(currentWeekString.startIndex, offsetBy: 3) ..< currentWeekString.index(currentWeekString.startIndex, offsetBy: 5)
        let weeksThisMonth = weeks.filter({ $0.week[range] == currentWeekInterval[range]})
        var totalEntries = 0
        for week in weeksThisMonth{
            for day in week.days{
                totalEntries += day.entries
            }
        }
        
        return totalEntries
    }
    
    func fetchMonthlyCoffe() -> Int{
        
        let currentWeekString = currentWeekInterval
        let range = currentWeekString.index(currentWeekString.startIndex, offsetBy: 3) ..< currentWeekString.index(currentWeekString.startIndex, offsetBy: 5)
        let weeksThisMonth = weeks.filter({ $0.week[range] == currentWeekInterval[range]})
        var totalCoffee = 0
        for week in weeksThisMonth{
            for day in week.days{
                totalCoffee += day.coffee
            }
        }
        
        return totalCoffee
    }
}

#Preview {
    QuickStatsMonthly()
}
