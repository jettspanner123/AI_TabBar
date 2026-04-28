import Foundation

class NetworkServiceHelper {
    public static let current = NetworkServiceHelper()
    
    enum NetworkServiceHelperError: Error {
        case invalidBaseURL
    }
    
    public func constructURL(endpoint: NetworkServiceEndpoints, subEndpoint: NetworkServiceSubEndpoints) -> URL? {
        guard let url = URL(string: "\(NetworkServiceConstants.current.BASE_URL)/\(endpoint.rawValue)/\(subEndpoint.rawValue)") else { return nil }
        return url
    }
}
