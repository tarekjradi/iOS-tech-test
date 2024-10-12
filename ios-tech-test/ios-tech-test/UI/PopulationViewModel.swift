//
//  PopulationViewModel.swift
//  ios-tech-test
//
//  Created by Tarek Jradi on 12/10/2024.
//

import Foundation

protocol PopulationViewModel {
    var statesData: [StateData] { get }
    var nationsData: [NationData] { get }
    func getStates(completion: @escaping (Error?) -> Void)
    func getNations(completion: @escaping (Error?) -> Void)
}

class DefaultPopulationViewModel: PopulationViewModel {
    
    // MARK: - private - Parameters
    private var populationService: PopulationService
    private var statesResult: [StateData] = []
    private var nationsResult: [NationData] = []

    // MARK: - Init
    init(populationService: PopulationService = DefaultPopulationService.shared) {
        self.populationService = populationService
    }
        
    // MARK: - public - protocol
    var statesData: [StateData] {
        return statesResult
    }

    var nationsData: [NationData] {
        return nationsResult
    }
    
    func getStates(completion: @escaping (Error?) -> Void) {
        populationService.getStates(completion: { result, error in
            guard let data = result?.data else {
                completion(error)
                return
            }
            for state in data {
                self.statesResult.append(state)
            }
            completion(nil)
        })
    }
    
    func getNations(completion: @escaping (Error?) -> Void) {
        populationService.getNations(completion: { result, error in
            guard let data = result?.data else {
                completion(error)
                return
            }
            for nation in data {
                self.nationsResult.append(nation)
            }
            completion(nil)
        })
    }

}
