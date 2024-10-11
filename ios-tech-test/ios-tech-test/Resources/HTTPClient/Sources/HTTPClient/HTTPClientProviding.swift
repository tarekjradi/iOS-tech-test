import Foundation

public protocol HTTPClientProviding: AnyObject {
    var delegate: HTTPClientDelegate? { get set }
    func performRequest(with requestData: RequestData)
    func performRequest(with requestData: RequestData,
                        completion: @escaping (Data?, Error?) -> Void)
}
