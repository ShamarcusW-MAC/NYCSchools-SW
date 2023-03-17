//
//  NetworkManager.swift
//  NYCSchools-SW
//
//  Created by Sha'Marcus Walker on 3/16/23.
//

import Foundation
protocol NetworkProtocol{
    func fetchData<Response>(endpoint: NYCSchoolsEndpoint<Response>, useCache: Bool) async throws -> Response
}
class NetworkManager:NetworkProtocol {
    
    lazy var jsonDecoder: JSONDecoder = {
        JSONDecoder()
    }()
    
    // Create a shared instance of URLCache
    static let sharedCache: URLCache = {
        let cacheSize = 50 * 1024 * 1024 // 50 MB
        let cache = URLCache(memoryCapacity: cacheSize, diskCapacity: cacheSize)
        return cache
    }()
    
    
    func fetchData<Response>(endpoint: NYCSchoolsEndpoint<Response>, useCache: Bool = false) async throws -> Response {
        
        if useCache, let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: endpoint.url)) {
            print("Fetched cached response for \(endpoint.url)")
            return try jsonDecoder.decode(Response.self, from: cachedResponse.data)
        }
        
        
        if let cachedResponse = NetworkManager.sharedCache.cachedResponse(for: URLRequest(url: endpoint.url)) {
            print("Cached response: \(cachedResponse)")
        } else {
            print("No cached response found.")
        }
        
        
        let (data, response) = try await URLSession.shared.data(from: endpoint.url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard(200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        if useCache {
            let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
            URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: endpoint.url))
            print("Stored response in cache for \(endpoint.url)")
        }
        
        return try jsonDecoder.decode(Response.self, from: data)

    }
}

