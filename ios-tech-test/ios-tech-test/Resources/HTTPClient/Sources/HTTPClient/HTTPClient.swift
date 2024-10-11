import Foundation

@objc public protocol HTTPClientDelegate: AnyObject {
    func success(response: Data?)
    func failure(error: Error)
}

public final class HTTPClient: HTTPStatusCodeHandling, HTTPClientProviding {
    private let session: URLSessionProtocol
    private let dataTaskBuilder: DataTaskBuilder
    weak public var delegate: HTTPClientDelegate?

    public convenience init(configuration: RequestConfiguration) {
        self.init(configuration: configuration, sessionProvider: DefaultURLSessionProvider())
    }

    init(configuration: RequestConfiguration, sessionProvider: URLSessionProviding) {
        session = sessionProvider.session()
        dataTaskBuilder = DataTaskBuilder(urlSession: session, baseUrl: configuration.baseUrl)
    }
    
    public func performRequest(with requestData: RequestData) {
        let task = dataTaskBuilder.task(from: requestData) { (data, response, error) in
            if let error = error {
                self.delegate?.failure(error: error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                self.delegate?.failure(error: HTTPClientError.noHTTPResponse)
                return
            }
            
            if self.isSuccessStatus(statusCode: httpResponse.statusCode) {
                self.delegate?.success(response: data)
            } else {
                let responseError = self.error(forHTTPStatus: httpResponse.statusCode)
                self.delegate?.failure(error: responseError)
            }
        }
        task?.resume()
    }
    
    public func performRequest(with requestData: RequestData, completion: @escaping (Data?, Error?) -> Void) {
        let task = dataTaskBuilder.task(from: requestData) { (data, response, error) in
            if let error = error {
                completion(data, error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(data, HTTPClientError.noHTTPResponse)
                return
            }
            
            if self.isSuccessStatus(statusCode: httpResponse.statusCode) {
                completion(data, nil)
            } else {
                let responseError = self.error(forHTTPStatus: httpResponse.statusCode)
                completion(data, responseError)
            }
        }
        task?.resume()
    }
    
}

