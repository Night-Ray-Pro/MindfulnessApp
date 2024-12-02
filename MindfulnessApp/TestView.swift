import Foundation

// Structs matching the JSON response
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

import SwiftUI

struct TestView: View {
    @State private var extractedText: String = "Waiting for response..."
    var inputString: String

    var body: some View {
        Text(extractedText)
        .padding()
        .task {
            fetchData()
        }
    }

    // Fetch data from the API
    func fetchData() {
        guard let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyDe_xngdDBgH-QyIgR5xZQks3psMEU-CL4") else {
            extractedText = "Invalid URL."
            return
        }

        // Prepare the request body
        let requestBody: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": "Rewrite this daily horoscope so it is more consise and sounds better and more like a prediction also do not use the horoscope sign name: \(inputString)"]
                    ]
                ]
            ]
        ]

        // Convert the request body to JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            extractedText = "Failed to encode JSON."
            return
        }

        // Configure the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        // Send the request
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    extractedText = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    extractedText = "No data received."
                }
                return
            }

            // Decode the JSON response
            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                if let firstText = response.candidates.first?.content.parts.first?.text {
                    DispatchQueue.main.async {
                        extractedText = firstText
                    }
                } else {
                    DispatchQueue.main.async {
                        extractedText = "No text found in response."
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    extractedText = "Failed to decode JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
#Preview {
    TestView(inputString: "You may find that you're taking a much more daring approach when it comes to love and romance now, Sagittarius. If you aren't, then maybe you should. You will never know the possibilities until you at least give it a try. You may find that there's something spurring you on today. Use that impulse to initiate a new path toward the object of your desire.")
}
