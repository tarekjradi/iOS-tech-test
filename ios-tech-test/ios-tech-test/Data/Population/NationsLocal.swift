//
//  NationsLocal.swift
//  ios-tech-test
//
//  Created by Tarek Jradi on 12/10/2024.
//

import Foundation

struct NationsLocal: Codable {
    let data: [NationDataLocal]
}

struct NationDataLocal: Codable {
    
    var IDNation: String?
    var IDYear: Int?
    var SlugNation: String?
    let Population: Int?
    let Nation: String?
    let Year: String?
    
    private enum CodingKeys : String, CodingKey {
        case IDNation = "ID Nation"
        case IDYear = "ID Year"
        case SlugNation = "Slug Nation"
        case Population
        case Nation
        case Year
    }
}
