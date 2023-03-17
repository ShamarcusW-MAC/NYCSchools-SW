//
//  School.swift
//  NYCSchools-SW
//
//  Created by Sha'Marcus Walker on 3/16/23.
//

import Foundation

struct School: Decodable, Hashable {
    let dbn: String
    let schoolName: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
    }
}
