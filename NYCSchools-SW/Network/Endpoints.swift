//
//  Endpoints.swift
//  NYCSchools-SW
//
//  Created by Sha'Marcus Walker on 3/16/23.
//

import Foundation

struct NYCSchoolsEndpoint<Response: Decodable> {
    let url: URL
    let responseType: Response.Type
}

class Endpoints {
    
    //Fetches the entire list of schools from New York City
    static func fetchNYCSchools() -> NYCSchoolsEndpoint<[School]> {
        NYCSchoolsEndpoint(url: URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")!, responseType: [School].self)
    }
    
    //Fetches the SAT scores of each school based on the school's dbn
    static func fetchNYCSchoolSATInfo(dbn: String) -> NYCSchoolsEndpoint<[SchoolSATInfo]> {
        NYCSchoolsEndpoint(url: URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=\(dbn)")!, responseType: [SchoolSATInfo].self)
    }
}
