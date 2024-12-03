//
//  Charts.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 3/12/24.
//

import SwiftUI
import Charts

struct SleepData: Identifiable {
    let id = UUID()
    let day: String
    let hours: Double
}

struct WeeklySleepChart: View {
    let week: String
    let sleepData: [SleepData]

    var body: some View {
        VStack {
            Text("\(week)")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .padding([.top, .horizontal])
                .frame(maxWidth: .infinity, alignment: .leading)

            Chart(sleepData) { data in
                BarMark(
                    x: .value("Day", data.day),
                    y: .value("Hours", data.hours)
                )
                .foregroundStyle(.white)
                .cornerRadius(5)
                
            }
//            .chartPlotStyle { plotArea in
//                plotArea
//                    .background(Color(.systemFill))
//                    .cornerRadius(10)
//            }
            .frame(height: 150)
            .padding()
        }
        .padding(.vertical)
        .frame(width: 345, height: 220)
        .background{
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        }
//        .background(.red)
    }
}

struct SleepChartView: View {
    let weeklyData = [
        (
            week: "2 Dec - 8 Dec",
            sleepData: [
                SleepData(day: "Mon", hours: 6),
                SleepData(day: "Tue", hours: 7.5),
                SleepData(day: "Wed", hours: 5.5),
                SleepData(day: "Thu", hours: 6),
                SleepData(day: "Fri", hours: 8),
                SleepData(day: "Sat", hours: 9),
                SleepData(day: "Sun", hours: 7)
            ]
        ),
        (
            week: "9 Dec - 15 Dec",
            sleepData: [
                SleepData(day: "Mon", hours: 7),
                SleepData(day: "Tue", hours: 6),
                SleepData(day: "Wed", hours: 7.5),
                SleepData(day: "Thu", hours: 5),
                SleepData(day: "Fri", hours: 8),
                SleepData(day: "Sat", hours: 9.5),
                SleepData(day: "Sun", hours: 6.5)
            ]
        )
    ]
    @State private var startingTab = "9 Dec - 15 Dec"
    var body: some View {
        TabView(selection: $startingTab) {
            ForEach(weeklyData, id: \.week) { weekData in
                WeeklySleepChart(week: weekData.week, sleepData: weekData.sleepData)
                    .tabItem {
                        Text(weekData.week)
                    }
                    .tag(weekData.week)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        
//        .frame(width: 345, height: 500)
    }
}

#Preview {
    SleepChartView()
}
