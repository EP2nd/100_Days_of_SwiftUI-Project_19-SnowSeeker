//
//  Resort.swift
//  SnowSeeker
//
//  Created by Edwin Przeźwiecki Jr. on 25/02/2023.
//

import Foundation

/// Challenge 3:
struct Resort: Codable, Identifiable, Comparable {
    
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    /// Challenge 3:
    static func <(lhs: Resort, rhs: Resort) -> Bool {
            return lhs.name < rhs.name
    }
    
    /// Alternative approach:
//    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
//    static let example = allResorts[0]
    
    static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
}
