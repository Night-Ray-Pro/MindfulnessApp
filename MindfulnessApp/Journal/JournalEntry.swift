//
//  JournalEntry.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 28/11/24.
//

import SwiftData
import Foundation

@Model
class JournalEntry {
    var id = UUID()
    var title: String
    var content: String
    var date: Date
//    var month: Int
//    var year: Int
    var location: String?
    var latitude: Double?
    var longitude: Double?
    var photoData: [Data]?
    
    init(title: String = "", content: String = "", date: Date = Date.now, location: String? = nil, latitude: Double? = nil, longitude: Double? = nil, photoData: [Data]? = [Data]()) {
        self.title = title
        self.content = content
        self.date = date
//        let components = Calendar.current.dateComponents([.day, .year, .month], from: date)
//        self.month = components.month ?? 0
//        self.year = components.year ?? 0
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
        self.photoData = photoData
    }
}
