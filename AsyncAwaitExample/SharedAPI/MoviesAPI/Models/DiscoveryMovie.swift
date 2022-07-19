//
//  DiscoveryMovie.swift
//  AsyncAwaitExample
//
//  Created by Austin Betzer on 7/18/22.
//

import Foundation

struct DiscoveryMoviesResult: Decodable {
    let movies: [DiscoveryMovie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct DiscoveryMovie: Decodable {
    let id: Int
    let backdropPath: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
    let releaseDate: String
    let overview: String
}
