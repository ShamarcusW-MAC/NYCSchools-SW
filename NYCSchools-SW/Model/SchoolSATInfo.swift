//
//  SchoolSATInfo.swift
//  NYCSchools-SW
//
//  Created by Sha'Marcus Walker on 3/16/23.
//

import Foundation

struct SchoolSAT: Decodable {
    let schoolResults: [SchoolSATInfo]
}

struct SchoolSATInfo: Decodable {
    let dbn: String
    let schoolName: String
    let numTestTakers: String
    let satReadingAvgScore: String
    let satMathAvgScore: String
    let satWritingAvgScore: String

    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case numTestTakers = "num_of_sat_test_takers"
        case satReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
}
