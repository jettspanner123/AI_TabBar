import Foundation

struct APIResponse<T: Codable>: Codable {
    public let success: Bool
    public let message: String
    let data: T?
}
