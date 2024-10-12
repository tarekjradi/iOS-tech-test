//
//  SerializationFormatter.swift
//  ios-tech-test
//
//  Created by Tarek Jradi on 11/10/2024.
//

import Foundation

private typealias Parameters = [String : Any]

class SerializationFormatter {

    // MARK: - public - Parameters
    static let standard = SerializationFormatter()
    
    // MARK: - public - Functions
    func parse<T: Codable>(with responseData: Data, model: T.Type) -> Any? {
        do {
            if let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                as? Parameters  {
                let jsonData = try JSONSerialization.data(withJSONObject: json)
                let response = try JSONDecoder().decode(T.self, from: jsonData)
                return response
                /// if the response is an `Array of Objects`
            } else if let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        as? [Parameters] {
                let jsonData = try JSONSerialization.data(withJSONObject: json)
                let response = try JSONDecoder().decode([T].self, from: jsonData)
                return response
            }
            else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
}
