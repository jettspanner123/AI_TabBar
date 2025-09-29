import Foundation
import GoogleGenerativeAI


struct ApplicationAIResponse {
    let error: String?
    let response: String?
}

class ApplicationAI {
    static let current = ApplicationAI()
    let model: GenerativeModel
    
    private init() {
        self.model = GenerativeModel(name: "gemini-2.5-flash", apiKey: "AIzaSyAWNhhUDsUMg7JMC7pBn3-WKhVdgpxkiMQ")
    }
    
    func generateResponseFrom(text: String, mood: String, explaination: Bool = false) async -> ApplicationAIResponse {
        
        let explainationPrompt: String = "Do not explain, do not add commentary. Just cut the case to the answer."
        let systemPrompt: String = """
            You are an API. 
            \(explaination ? "" : explainationPrompt)
            Do not include any formatting such as Markdown code blocks. 
            Make sure the response is raw text and nothing else....no json or anything like that.
            Make sure not to use any kind of text decoration like `.
        
            Set your mood as if the user is asking prompt or questions acording to \(mood)
        """
        
        do {
            let result = try await self.model.generateContent(systemPrompt + text)
            return ApplicationAIResponse(error: nil, response: result.text ?? "No Response!")
        } catch {
            return ApplicationAIResponse(error: error.localizedDescription, response: nil)
        }
    }
    
}
