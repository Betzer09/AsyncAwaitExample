//
//  SearchCollectionViewModel.swift
//  AsyncAwaitExample
//
//  Created by Austin Betzer on 7/18/22.
//

import Foundation
import Combine


class DiscoverCollectionViewModel {
    // MARK: -  Dependiens
    let discoveryAPI: DiscoverMoviesAPILogic = DiscoverMoviesAPI()
    
    @Published var movies: [DiscoveryMovie] = []
    private var loadingTask: Task<Void, Never>?
    
    deinit {
        loadingTask?.cancel()
    }
    
    
    func fetchMovies() {
        loadingTask =  Task {
            let requestedMovies = try? await discoveryAPI.fetchDiscoveryMovies(1)
            self.movies = requestedMovies ?? []
        }
    }
}
