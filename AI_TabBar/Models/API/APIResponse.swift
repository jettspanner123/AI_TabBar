import Foundation

struct APIResponse<T: Codable>: Codable, Identifiable {
    public var id: String = UUID().uuidString
    public let success: Bool
    public let message: String
    let data: T?
}
