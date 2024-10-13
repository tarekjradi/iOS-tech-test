//
//  PopulationRequest.swift
//  ios-tech-test
//
//  Created by Tarek Jradi on 11/10/2024.
//

import Foundation
import HTTPClient

private enum RequestError: Error {
    case invalidRequest
    case serialization
}

protocol PopulationRequest {
    func getNations(completion: @escaping (NationsLocal?, Error?) -> Void)
    func getStates(completion: @escaping (StatesLocal?, Error?) -> Void)
}

class DefaultPopulationRequest: PopulationRequest {
    // MARK: - public - Parameters
    static let shared: PopulationRequest = DefaultPopulationRequest()

    // MARK: - private - Parameters
    private var client: HTTPClientProviding
    
    // MARK: - Init
    init(client: HTTPClient = HTTPClient(configuration: RequestConfig.baseURL)) {
        self.client = client
    }

    // MARK: - public - Functions
    func getNations(completion: @escaping (NationsLocal?, Error?) -> Void) {
        
        var requestDataPopulation: RequestData {
            return RequestData(
                method: .get,
                path: RequestConfig.Domain.path.rawValue,
                parameters: ["drilldowns" : "Nation",
                             "measures" : "Population"]
            )
        }
        
        client.performRequest(with: requestDataPopulation) { data, error in
            guard error == nil, let responseData = data else { completion(nil, error); return }
            guard let nations: NationsLocal = SerializationFormatter.standard.parse(
                with: responseData,
                model: NationsLocal.self) as? NationsLocal else {
                    completion(nil, RequestError.serialization)
                    return
            }
            completion(nations, nil)
        }
    }
    
    func getStates(completion: @escaping (StatesLocal?, Error?) -> Void) {
        
        var requestDataPopulation: RequestData {
            return RequestData(
                method: .get,
                path: RequestConfig.Domain.path.rawValue,
                parameters: ["drilldowns" : "State",
                             "measures" : "Population",
                             "year" : "latest"]
            )
        }
        
        client.performRequest(with: requestDataPopulation) { data, error in
            guard error == nil, let responseData = data else { completion(nil, error); return }
            guard let states: StatesLocal = SerializationFormatter.standard.parse(
                with: responseData,
                model: StatesLocal.self) as? StatesLocal else {
                    completion(nil, RequestError.serialization)
                    return
            }
            completion(states, nil)
        }
    }
}
