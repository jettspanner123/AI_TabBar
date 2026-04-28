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
        guard let imageData else { return APIResponse(success: false, message: "Image Data Not Found!", data: nil)}
        
        let requestURL = URLRequest(url: NetworkServiceHelper.current.constructURL(endpoint: .ai, subEndpoint: .getMCPAnswer))
        requestURL.httpMethod = "POST"
        
    }
}
