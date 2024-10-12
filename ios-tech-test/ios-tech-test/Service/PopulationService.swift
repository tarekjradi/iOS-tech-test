//
//  PopulationService.swift
//  ios-tech-test
//
//  Created by Tarek Jradi on 12/10/2024.
//

import Foundation

protocol PopulationService {
    func getNations(completion: @escaping (Nations?, Error?) -> Void)
    func getStates(completion: @escaping (States?, Error?) -> Void)
}

class DefaultPopulationService: PopulationService {
    
    // MARK: - private - Parameters
    private var populationRepository: PopulationRepository
    static let shared: PopulationService = DefaultPopulationService()

    private let nationLocalToNation: (NationDataLocal) -> NationData = {
        return NationData(IDNation: $0.IDNation,
                          IDYear: $0.IDYear,
                          SlugNation: $0.SlugNation,
                          Population: $0.Population,
                          Nation: $0.Nation,
                          Year: $0.Year)
    }

    private let stateLocalToState: (StateDataLocal) -> StateData = {
        return StateData(IDState: $0.IDState,
                         IDYear: $0.IDYear,
                         SlugState: $0.SlugState,
                         Population: $0.Population,
                         State: $0.State,
                         Year: $0.Year)
    }

    // MARK: - Init
    init(populationRepository: PopulationRepository = DefaultPopulationRepository.shared) {
        self.populationRepository = populationRepository
    }

    // MARK: - public - Functions
    func getNations(completion: @escaping (Nations?, Error?) -> Void) {
        populationRepository.getNations(completion: { [weak self] response, error in
            guard let self = self else { completion(nil, error); return }
            guard error == nil, let nationsLocal: NationsLocal = response else {
                completion(nil, error); return
            }
            let data = nationsLocal.data.map {
                self.nationLocalToNation($0)
            }
            let nations = Nations(data: data)
            completion(nations, nil)
        })
    }

    func getStates(completion: @escaping (States?, Error?) -> Void) {
        populationRepository.getStates(completion: { [weak self] response, error in
            guard let self = self else { completion(nil, error); return }
            guard error == nil, let statesLocal: StatesLocal = response else {
                completion(nil, error); return
            }
            let data = statesLocal.data.map {
                self.stateLocalToState($0)
            }
            let states = States(data: data)
            completion(states, nil)
        })
    }

}
