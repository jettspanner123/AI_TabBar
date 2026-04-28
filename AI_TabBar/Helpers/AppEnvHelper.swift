import Foundation

enum AppEnvError: Error {
    case missingKey(String)
}

class AppEnvHelper {
    public static let current = AppEnvHelper()
    
    public func get(_ key: String) throws -> String {
        if let value = ProcessInfo.processInfo.environment[key] {
            return value
        } else {
            throw AppEnvError.missingKey(key)
        }
    }
}
