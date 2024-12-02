
import SwiftUI

struct TestView: View {
    let APIkey = "AIzaSyDv_e1yB2_XQV9fqhAlfE6SYd7iYp1fCm0"
    @State private var extractedText: String = "Waiting for response..."
    var inputString: String

    var body: some View {
        Text(extractedText)
        .padding()
        .task {
            await fetchData()
        }
    }

    // Fetch data from the API
    func fetchData() async {
        guard let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=\(APIkey)") else {
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
        
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            if let decodedResponse = try? JSONDecoder().decode(APIResponse.self, from: data){
                extractedText = decodedResponse.candidates.first?.content.parts.first?.text ?? "Error"
            }
            
            
        }catch{
            print(error.localizedDescription)
        }

        
    }
}
#Preview {
    TestView(inputString: "You may find that you're taking a much more daring approach when it comes to love and romance now, Sagittarius. If you aren't, then maybe you should. You will never know the possibilities until you at least give it a try. You may find that there's something spurring you on today. Use that impulse to initiate a new path toward the object of your desire.")
}
