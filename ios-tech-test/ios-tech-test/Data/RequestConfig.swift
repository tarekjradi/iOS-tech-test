//
//  RequestConfig.swift
//  ios-tech-test
//
//  Created by Tarek Jradi on 11/10/2024.
//

import Foundation
import HTTPClient

struct RequestConfig {
    static let baseURL = RequestConfiguration(baseUrl: URL(string: Domain.production.rawValue)!)
    
    enum Domain: String {
        case production = "https://datausa.io/"
        case path = "api/data/"
    }
}
