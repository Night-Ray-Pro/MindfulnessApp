//
//  Charts.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 3/12/24.
//

import Charts
import SwiftData
import SwiftUI

struct chartData: Identifiable{
    let id: UUID = UUID()
    var data: Int
    let weekDay: String
}

struct WeeklySleepChart: View {
    let week: String
    var sleepData: [chartData]
    
    init(week: String, sleepData: [Day]){
        self.sleepData = [
            chartData(data: 0, weekDay: "Mon"),
            chartData(data: 0, weekDay: "Tue"),
            chartData(data: 0, weekDay: "Wed"),
            chartData(data: 0, weekDay: "Thu"),
            chartData(data: 0, weekDay: "Fri"),
            chartData(data: 0, weekDay: "Sat"),
            chartData(data: 0, weekDay: "Sun")
        ]
        self.week = week
        for day in sleepData{
            let index = self.sleepData.firstIndex { $0.weekDay == day.weekDay }
            if let index{
                self.sleepData[index].data = day.sleep
            }
        }
    }

    var body: some View {
        VStack {
            Text("\(week)")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .padding([.top, .horizontal])
                .frame(maxWidth: .infinity, alignment: .leading)

            Chart(sleepData) { dataIn in
                BarMark(
                    x: .value("Day", dataIn.weekDay),
                    y: .value("Hours", dataIn.data)
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
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
    @State private var startingTab: String
    init(){
        
        var currentWeekInterval: String {
            guard let interval = Calendar.current.dateInterval(of: .weekOfMonth, for: Date.now) else { return "N/A" }
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM"
            let startDate = formatter.string(from: interval.start)
            let endDate = formatter.string(from: interval.end)
            return "\(startDate) - \(endDate) \(Calendar.current.component(.year, from: Date.now))"
        }
        self.startingTab = currentWeekInterval
    }
    var body: some View {
        TabView(selection: $startingTab) {
            ForEach(weeks.reversed(), id: \.week) { weekData in
                WeeklySleepChart(week: weekData.week, sleepData: weekData.days)
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

struct WeeklyCoffeeChart: View {
    let week: String
    var sleepData: [chartData]
    
    init(week: String, sleepData: [Day]){
        self.sleepData = [
            chartData(data: 0, weekDay: "Mon"),
            chartData(data: 0, weekDay: "Tue"),
            chartData(data: 0, weekDay: "Wed"),
            chartData(data: 0, weekDay: "Thu"),
            chartData(data: 0, weekDay: "Fri"),
            chartData(data: 0, weekDay: "Sat"),
            chartData(data: 0, weekDay: "Sun")
        ]
        self.week = week
        for day in sleepData{
            let index = self.sleepData.firstIndex { $0.weekDay == day.weekDay }
            if let index{
                self.sleepData[index].data = day.coffee
            }
        }
    }

    var body: some View {
        VStack {
            Text("\(week)")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .padding([.top, .horizontal])
                .frame(maxWidth: .infinity, alignment: .leading)

            Chart(sleepData) { dataIn in
                BarMark(
                    x: .value("Day", dataIn.weekDay),
                    y: .value("Hours", dataIn.data)
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

struct CoffeeChartView: View {
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
    @State private var startingTab: String
    init(){
        
        var currentWeekInterval: String {
            guard let interval = Calendar.current.dateInterval(of: .weekOfMonth, for: Date.now) else { return "N/A" }
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM"
            let startDate = formatter.string(from: interval.start)
            let endDate = formatter.string(from: interval.end)
            return "\(startDate) - \(endDate) \(Calendar.current.component(.year, from: Date.now))"
        }
        self.startingTab = currentWeekInterval
    }
    var body: some View {
        TabView(selection: $startingTab) {
            ForEach(weeks.reversed(), id: \.week) { weekData in
                WeeklyCoffeeChart(week: weekData.week, sleepData: weekData.days)
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

struct WeeklyMeditationChart: View {
    let week: String
    var sleepData: [chartData]
    
    init(week: String, sleepData: [Day]){
        self.sleepData = [
            chartData(data: 0, weekDay: "Mon"),
            chartData(data: 0, weekDay: "Tue"),
            chartData(data: 0, weekDay: "Wed"),
            chartData(data: 0, weekDay: "Thu"),
            chartData(data: 0, weekDay: "Fri"),
            chartData(data: 0, weekDay: "Sat"),
            chartData(data: 0, weekDay: "Sun")
        ]
        self.week = week
        for day in sleepData{
            let index = self.sleepData.firstIndex { $0.weekDay == day.weekDay }
            if let index{
                self.sleepData[index].data = day.meditation/60
            }
        }
    }

    var body: some View {
        VStack {
            Text("\(week)")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .padding([.top, .horizontal])
                .frame(maxWidth: .infinity, alignment: .leading)

            Chart(sleepData) { dataIn in
                BarMark(
                    x: .value("Day", dataIn.weekDay),
                    y: .value("Hours", dataIn.data)
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

struct MeditationChartView: View {
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
    @State private var startingTab: String
    init(){
        
        var currentWeekInterval: String {
            guard let interval = Calendar.current.dateInterval(of: .weekOfMonth, for: Date.now) else { return "N/A" }
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM"
            let startDate = formatter.string(from: interval.start)
            let endDate = formatter.string(from: interval.end)
            return "\(startDate) - \(endDate) \(Calendar.current.component(.year, from: Date.now))"
        }
        self.startingTab = currentWeekInterval
    }
    var body: some View {
        TabView(selection: $startingTab) {
            ForEach(weeks.reversed(), id: \.week) { weekData in
                WeeklyMeditationChart(week: weekData.week, sleepData: weekData.days)
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

struct WeeklyMoodChart: View {
    let week: String
    var sleepData: [chartData]
    
    init(week: String, sleepData: [Day]){
        self.sleepData = [
            chartData(data: 0, weekDay: "Mon"),
            chartData(data: 0, weekDay: "Tue"),
            chartData(data: 0, weekDay: "Wed"),
            chartData(data: 0, weekDay: "Thu"),
            chartData(data: 0, weekDay: "Fri"),
            chartData(data: 0, weekDay: "Sat"),
            chartData(data: 0, weekDay: "Sun")
        ]
        self.week = week
        for day in sleepData{
            let index = self.sleepData.firstIndex { $0.weekDay == day.weekDay }
            if let index{
                self.sleepData[index].data = day.mood
            }
        }
    }

    var body: some View {
        VStack {
            Text("\(week)")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .padding([.top, .horizontal])
                .frame(maxWidth: .infinity, alignment: .leading)

            Chart(sleepData) { dataIn in
                BarMark(
                    x: .value("Day", dataIn.weekDay),
                    y: .value("Hours", dataIn.data)
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

struct MoodChartView: View {
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
    @State private var startingTab: String
    init(){
        
        var currentWeekInterval: String {
            guard let interval = Calendar.current.dateInterval(of: .weekOfMonth, for: Date.now) else { return "N/A" }
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM"
            let startDate = formatter.string(from: interval.start)
            let endDate = formatter.string(from: interval.end)
            return "\(startDate) - \(endDate) \(Calendar.current.component(.year, from: Date.now))"
        }
        self.startingTab = currentWeekInterval
    }
    var body: some View {
        TabView(selection: $startingTab) {
            ForEach(weeks.reversed(), id: \.week) { weekData in
                WeeklyMoodChart(week: weekData.week, sleepData: weekData.days)
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

struct WeeklyJournalChart: View {
    let week: String
    var sleepData: [chartData]
    
    init(week: String, sleepData: [Day]){
        self.sleepData = [
            chartData(data: 0, weekDay: "Mon"),
            chartData(data: 0, weekDay: "Tue"),
            chartData(data: 0, weekDay: "Wed"),
            chartData(data: 0, weekDay: "Thu"),
            chartData(data: 0, weekDay: "Fri"),
            chartData(data: 0, weekDay: "Sat"),
            chartData(data: 0, weekDay: "Sun")
        ]
        self.week = week
        for day in sleepData{
            let index = self.sleepData.firstIndex { $0.weekDay == day.weekDay }
            if let index{
                self.sleepData[index].data = day.entries
            }
        }
    }

    var body: some View {
        VStack {
            Text("\(week)")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .padding([.top, .horizontal])
                .frame(maxWidth: .infinity, alignment: .leading)

            Chart(sleepData) { dataIn in
                BarMark(
                    x: .value("Day", dataIn.weekDay),
                    y: .value("Hours", dataIn.data)
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

struct JournalChartView: View {
    @Query(sort: \ApplicationData.date, order: .reverse) var weeks: [ApplicationData]
    @State private var startingTab: String
    init(){
        
        var currentWeekInterval: String {
            guard let interval = Calendar.current.dateInterval(of: .weekOfMonth, for: Date.now) else { return "N/A" }
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM"
            let startDate = formatter.string(from: interval.start)
            let endDate = formatter.string(from: interval.end)
            return "\(startDate) - \(endDate) \(Calendar.current.component(.year, from: Date.now))"
        }
        self.startingTab = currentWeekInterval
    }
    var body: some View {
        TabView(selection: $startingTab) {
            ForEach(weeks.reversed(), id: \.week) { weekData in
                WeeklyJournalChart(week: weekData.week, sleepData: weekData.days)
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
