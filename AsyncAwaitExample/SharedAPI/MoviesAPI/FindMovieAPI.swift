//
//  FindMovieAPI.swift
//  AsyncAwaitExample
//
//  Created by Austin Betzer on 7/19/22.
//

import Foundation

protocol FindMoviesAPILogic {
    
}


class FindMoviesAPI: FindMoviesAPILogic {
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    enum DiscoveryError: Error {
        case non200HTTPResponseError
    }
    
    func searchForMovieWith(title: String) {
        let pageItem = URLQueryItem(name: "query", value: "\(title)")
        let url = buildSignedURL(withPath: "discover/movie", queryItems: [pageItem])
        
    }
    
    func searchForMovieRecommendationSimilarToMovie(withId id: Int) {
        let url = buildSignedURL(withPath: "/movie/\(id)/recommendations")
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
