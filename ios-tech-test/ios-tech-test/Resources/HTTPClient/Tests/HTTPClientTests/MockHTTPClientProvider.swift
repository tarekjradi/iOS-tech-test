@testable import HTTPClient
import Foundation

final class MockHTTPClientProvider: HTTPClientProviding {
    var delegate: HTTPClientDelegate?
    var didPerformRequest = false
    var spyPerformedRequestData: RequestData?
    func performRequest(with data: RequestData) {
        didPerformRequest = true
        spyPerformedRequestData = data
    }

    func performRequest(with requestData: RequestData, completion: @escaping (Data?, Error?) -> Void) {
        fatalError()
    }
}
