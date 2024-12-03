//
//  APICallsStructs.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 2/12/24.
//

import Foundation

struct moonPhases: Codable {
    var Phases: [moonPhase]
}

struct moonPhase: Codable {
    let phase: String
    
    enum CodingKeys: String, CodingKey {
        case phase = "Phase"
    }
}

struct dailyQuote: Codable {
    let content: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case content = "content"
        case author = "author"
    }
}

struct Horoscope: Codable {
    let data: HoroscopeData
    let status: Int
    
    enum CodingKeys: String, CodingKey{
        case data = "data"
        case status = "status"
    }
}

struct HoroscopeData: Codable {
    let horoscopeData: String
    let week: String
    
    enum CodingKeys: String, CodingKey{
        case horoscopeData = "horoscope_data"
        case week = "week"
    }
}




