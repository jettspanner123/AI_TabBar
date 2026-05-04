import Foundation

class NetworkServiceConstants {
    public static let current = NetworkServiceConstants()
    
    public let BASE_URL: String = "http://localhost:3000"
    
}

enum NetworkServiceEndpoints: String {
    case ai = "ai"
}

enum NetworkServiceSubEndpoints: String {
    case getMCQAnswer = "mcq", askAI = "ask"
}
