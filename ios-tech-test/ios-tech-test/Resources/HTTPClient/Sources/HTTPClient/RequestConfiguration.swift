import Foundation

public struct RequestConfiguration {
    let baseUrl: URL
    
    public init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
}
