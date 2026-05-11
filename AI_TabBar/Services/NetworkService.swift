import Foundation

private extension URLRequest {
    mutating func addInternalRouteKey() {
        self.setValue("OGOGOGUD", forHTTPHeaderField: "internal-route-key")
    }
}

class NetworkService {
    public static let current = NetworkService()
    public let get = NetworkGetServiceHelper()
    public let post = NetworkPostServiceHelper()
}


class NetworkGetServiceHelper {
    
    public func getAISearchAnswer(query: String) async throws -> APIResponse<AskAIQuestionResponse> {
        guard query.count >= 3 else {
            return APIResponse(success: false, message: "The query should be at least 3 characters!", data: nil)
        }
        
        var requestURL = URLRequest(url: NetworkServiceHelper.current.constructURL(endpoint: .ai, subEndpoint: .askAI)!)
        requestURL.httpMethod = "POST"
        let requestBody = ["prompt": query]
        requestURL.httpBody = try? JSONEncoder().encode(requestBody)
        requestURL.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestURL.addInternalRouteKey()
        
        let (data, _) = try await URLSession.shared.data(for: requestURL)
        
        do {
            print(data)
            return try JSONDecoder().decode(APIResponse<AskAIQuestionResponse>.self, from: data)
        } catch {
            print("Decoding error:", error)
            print(String(data: data, encoding: .utf8) ?? "Invalid response")
            return APIResponse(success: false, message: "Decoding Error! \(error)", data: nil)
        }
    }
    
    public func getAISearchDifferenceAnswer(query: String) async throws -> APIResponse<AskAIDifferenceQuestionResponse> {
        guard query.count >= 3 else {
            return APIResponse(success: false, message: "The query should be at least 3 characters!", data: nil)
        }
        
        var requestURL = URLRequest(url: NetworkServiceHelper.current.constructURL(endpoint: .ai, subEndpoint: .difference)!)
        requestURL.httpMethod = "POST"
        let requestBody = ["prompt": query]
        requestURL.httpBody = try? JSONEncoder().encode(requestBody)
        requestURL.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestURL.addInternalRouteKey()
        
        let (data, _) = try await URLSession.shared.data(for: requestURL)
        
        do {
            print(data)
            return try JSONDecoder().decode(APIResponse<AskAIDifferenceQuestionResponse>.self, from: data)
        } catch {
            print("Decoding error:", error)
            print(String(data: data, encoding: .utf8) ?? "Invalid response")
            return APIResponse(success: false, message: "Decoding Error! \(error)", data: nil)
        }
    }
    
    public func getAISearchCodeAnswer(query: String) async throws -> APIResponse<AskAICodeQuestionResponse> {
        guard query.count >= 3 else {
            return APIResponse(success: false, message: "The query should be at least 3 characters!", data: nil)
        }
        
        var requestURL = URLRequest(url: NetworkServiceHelper.current.constructURL(endpoint: .ai, subEndpoint: .code)!)
        requestURL.httpMethod = "POST"
        let requestBody = ["prompt": query]
        requestURL.httpBody = try? JSONEncoder().encode(requestBody)
        requestURL.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestURL.addInternalRouteKey()
        
        let (data, _) = try await URLSession.shared.data(for: requestURL)
        
        do {
            print(data)
            return try JSONDecoder().decode(APIResponse<AskAICodeQuestionResponse>.self, from: data)
        } catch {
            print("Decoding error:", error)
            print(String(data: data, encoding: .utf8) ?? "Invalid response")
            return APIResponse(success: false, message: "Decoding Error! \(error)", data: nil)
        }
    }
    
}

class NetworkPostServiceHelper {
    public func getMultipleChoiseQuestionAnswer(imageData: Data?) async throws -> APIResponse<MCQDataResponse> {
        guard let imageData else {
            return APIResponse(success: false, message: "Image Data Not Found!", data: nil)
        }
        
        var requestURL = URLRequest(url: NetworkServiceHelper.current.constructURL(endpoint: .ai, subEndpoint: .getMCQAnswer)!)
        requestURL.httpMethod = "POST"
        requestURL.httpBody = imageData
        requestURL.addInternalRouteKey()
        
        let (data, _) = try await URLSession.shared.data(for: requestURL)
        
        do {
            return try JSONDecoder().decode(APIResponse<MCQDataResponse>.self, from: data)
        } catch {
            print("Decoding error:", error)
            print(String(data: data, encoding: .utf8) ?? "Invalid response")
            return APIResponse(success: false, message: "Decoding Error! \(error)", data: nil)
        }
    }
}
