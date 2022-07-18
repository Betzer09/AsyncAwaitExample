//
//  MoviesAPI.swift
//  AsyncAwaitExample
//
//  Created by Austin Betzer on 7/18/22.
//

import Foundation

protocol DiscoverMoviesAPILogic {
    func fetchDiscoveryMovies(_ page: Int) async throws -> DiscoveryMovie
}


struct DiscoverMoviesAPI: DiscoverMoviesAPILogic {
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    
    private init() {}
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    enum DiscoveryError: Error {
        case non200HTTPResponseError
    }
    
    func fetchDiscoveryMovies(_ page: Int = 1) async throws -> DiscoveryMovie {
        let pageItem = URLQueryItem(name: "page", value: "\(page)")
        let url = buildSignedURL(withPath: "discover/movie", queryItems: [pageItem])
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw DiscoveryError.non200HTTPResponseError
        }
        
        return try jsonDecoder.decode(DiscoveryMovie.self, from: data)
    }

    private func buildSignedURL(withPath path: String, queryItems: [URLQueryItem] = []) -> URL {
        let key = Keys.movieDBKey
        let path = baseURL.appendingPathComponent(path)
        var urlComponent = URLComponents(url: path, resolvingAgainstBaseURL: false)
        let queryItem = URLQueryItem(name: "api_key", value: key)
        urlComponent?.queryItems = [queryItem] + queryItems
        
        guard let fullURL = urlComponent?.url else {
            fatalError("Failed to build URL in file: \(#file)")
        }
        
        return fullURL
    }
}
