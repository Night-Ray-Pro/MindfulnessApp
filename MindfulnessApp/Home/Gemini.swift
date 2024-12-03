//
//  Gemini.swift
//  MindfulnessApp
//
//  Created by Oskar Kapuśniak on 3/12/24.
//

import Foundation

struct APIResponse: Codable {
    let candidates: [Candidate]
}

struct Candidate: Codable {
    let content: MyContent
}

struct MyContent: Codable {
    let parts: [Part]
}

struct Part: Codable {
    let text: String
}
//Rewrite this daily horoscope so it is more consise and sounds better and more like a prediction also do not use the horoscope sign name: \(query)
struct Gemini {
    static let apiKey = "AIzaSyDv_e1yB2_XQV9fqhAlfE6SYd7iYp1fCm0"
    
    static func fetchResponse(for query: String) async -> String {
        guard let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=\(apiKey)")
        else {
            return "Invalid URL."
        }
        let requestBody: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": "\(query)"]
                    ]
                ]
            ]
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            return "Failed to encode body."
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            if let decodedResponse = try? JSONDecoder().decode(APIResponse.self, from: data){
                return decodedResponse.candidates.first?.content.parts.first?.text ?? "Error in decoding request"
            }
        }catch{
            return error.localizedDescription
        }
        return "Error in fetching response"
        
    }
}
