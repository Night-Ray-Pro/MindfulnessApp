//
//  ApplicationData.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 4/12/24.
//

import Foundation
import SwiftData

@Model
class ApplicationData: Identifiable{
    var id: UUID = UUID()
    var date: Date = Date.now
    var week: String
    @Relationship(deleteRule: .cascade) var days: [Day]
    var horoscope: String
    
    init(week: String = "", days: [Day] = [Day](), horoscope: String = "") {
        self.week = week
        self.days = days
        self.horoscope = horoscope
    }
}
@Model
class Day: Identifiable{
    var id: UUID = UUID()
    var author: String
    var quote: String
    var date: Date
    var weekDay: String
    var dayIdentyfier: String
    var coffee: Int
    var sleep: Int
    var meditation: Int
    var mood: Int
    var entries: Int
    var moonPhase: String
    
    init(author: String = "", quote: String = "", date: Date = .now, weekDay: String = "", dayIdentyfier: String = "", coffee: Int = 0, sleep: Int = 0, meditation: Int = 0, mood: Int = 4, entries: Int = 0, moonPhase: String = "") {
        self.author = author
        self.quote = quote
        self.date = date
        self.weekDay = weekDay
        self.dayIdentyfier = dayIdentyfier
        self.coffee = coffee
        self.sleep = sleep
        self.meditation = meditation
        self.mood = mood
        self.entries = entries
        self.moonPhase = moonPhase
    }
    
}
