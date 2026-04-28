import Foundation


class NetworkService {
    public static let current = NetworkService()
    public let get = NetworkGetServiceHelper()
    public let post = NetworkPostServiceHelper()
}


class NetworkGetServiceHelper {
    
}

class NetworkPostServiceHelper {
    public func getMultipleChoiseQuestionAnswer(imageData: Data?) async throws -> APIResponse<MCQDataResponse> {
        guard let imageData else {
            return APIResponse(success: false, message: "Image Data Not Found!", data: nil)
        }
        
        var requestURL = URLRequest(url: NetworkServiceHelper.current.constructURL(endpoint: .ai, subEndpoint: .getMCQAnswer)!)
        requestURL.httpMethod = "POST"
        requestURL.httpBody = imageData
        
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
