//
//  PopulationRepository.swift
//  ios-tech-test
//
//  Created by Tarek Jradi on 11/10/2024.
//

import Foundation

protocol PopulationRepository {
    func getStates(completion: @escaping (StatesLocal?, Error?) -> Void)
    func getNations(completion: @escaping (NationsLocal?, Error?) -> Void)
}

class DefaultPopulationRepository: PopulationRepository {

    // MARK: - public - Parameters
    static let shared: PopulationRepository = DefaultPopulationRepository()

    // MARK: - private - Parameters
    private var clientHTTP: PopulationRequest
    
    // MARK: - Init
    init(clientHTTP: PopulationRequest = DefaultPopulationRequest()) {
        self.clientHTTP = clientHTTP
    }

    // MARK: - public - Functions
    func getStates(completion: @escaping (StatesLocal?, Error?) -> Void) {
        clientHTTP.getStates(completion: { response, error in
            completion(response, error)
        })
    }
    
    func getNations(completion: @escaping (NationsLocal?, Error?) -> Void) {
        clientHTTP.getNations(completion: { response, error in
            completion(response, error)
        })
    }
}
