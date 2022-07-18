//
//  DiscoveryMovie.swift
//  AsyncAwaitExample
//
//  Created by Austin Betzer on 7/18/22.
//

import Foundation

struct DiscoveryMovie: Decodable {
    let backdropPath: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
    let releaseDate: String
    let overview: String
}
