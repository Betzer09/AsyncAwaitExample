//
//  ImageAPI.swift
//  AsyncAwaitExample
//
//  Created by Austin Betzer on 6/28/22.
//

import Foundation

protocol ImageAPILogic {
    func fetchImageWith(backdropPath path: String) async throws -> ImageAPI.ImageResponse
}

struct ImageAPI: ImageAPILogic {
    typealias ImageResponse = Data
    
    private struct Constants {
        static let posterPath = "https://image.tmdb.org/t/p/w780"
    }
    
    enum APIError: Error {
        case invalidURL
        case networkingError(String)
    }
    
    
    func fetchImageWith(backdropPath path: String) async throws -> ImageResponse {
        return try await downloadImage(withImageBackdropPath: path)
    }
    
    private func downloadImage(withImageBackdropPath path: String) async throws -> ImageResponse {
        guard let url = URL(string: "\(Constants.posterPath)\(path)") else {
            throw APIError.invalidURL
        }
        
        // New async api from URLSession
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return data
    }
}
