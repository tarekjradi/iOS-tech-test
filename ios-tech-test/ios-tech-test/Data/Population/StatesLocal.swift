//
//  StatesLocal.swift
//  ios-tech-test
//
//  Created by Tarek Jradi on 11/10/2024.
//

import Foundation

struct StatesLocal: Codable {
    let data: [StateDataLocal]
}

struct StateDataLocal: Codable {
    
    var IDState: String?
    var IDYear: Int?
    var SlugState: String?
    let Population: Int?
    let State: String?
    let Year: String?
    
    private enum CodingKeys : String, CodingKey {
        case IDState = "ID State"
        case IDYear = "ID Year"
        case SlugState = "Slug State"
        case Population
        case State
        case Year
    }
}
