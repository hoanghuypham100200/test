import Foundation


class OpenAIManager {
    static let shared = OpenAIManager()

    private let apiKey = "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"
    private let endpoint = "https://api.groq.com/openai/v1/chat/completions"

    private init() {}

    // Return response as an array of [content, role]
    func sendMessage(messages: [[String: String]], completion: @escaping (Result<[[String: String]], Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let headers: [String: String] = [
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/json"
        ]

        let parameters: [String: Any] = [
            "model": "llama-3.3-70b-versatile", // or "gpt-4"
            "messages": messages,
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String,
                   let role = message["role"] as? String {
                    let response = [
                        ["content": content, "role": role]
                    ]
                    completion(.success(response))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"])))
                }
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
