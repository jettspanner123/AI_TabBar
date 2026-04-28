import Foundation

class NetworkServiceConstants {
    public static let current = NetworkServiceConstants()
    
    public let BASE_URL: String = "http://localhost:8080/api/v1"
    
}

enum NetworkServiceEndpoints: String {
    case ai = "ai"
}

enum NetworkServiceSubEndpoints: String {
    case getMCQAnswer = "mcq"
}
