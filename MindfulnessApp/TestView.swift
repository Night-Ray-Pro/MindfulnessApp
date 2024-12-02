import SwiftUI

struct TestView: View {
    @State private var responseText: String = "Waiting for response..."
    
    var body: some View {
        VStack {
            Text("API Response:")
                .font(.headline)
                .padding()
            
            Text(responseText)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                sendAPIRequest()
            }) {
                Text("Send API Request")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    func sendAPIRequest() {
        // Define the API URL
        guard let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyDe_xngdDBgH-QyIgR5xZQks3psMEU-CL4") else {
            responseText = "Invalid URL."
            return
        }
        
        // Create the request body
        let requestBody: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": "Explain how AI works"]
                    ]
                ]
            ]
        ]
        
        // Convert the body to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            responseText = "Failed to encode JSON."
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    responseText = "Error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    responseText = "No data received."
                }
                return
            }
            
            // Decode the response
            if let responseString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    responseText = responseString
                }
            } else {
                DispatchQueue.main.async {
                    responseText = "Failed to decode response."
                }
            }
        }
        
        task.resume()
    }
}
#Preview {
    TestView()
}
