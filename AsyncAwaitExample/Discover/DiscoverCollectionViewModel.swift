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
    var currentPage = 0
    
    deinit {
        loadingTask?.cancel()
    }
    
    
    func fetchMovies(page: Int = 1) {
        loadingTask = Task {
            currentPage += 1
            let requestedMovies = try? await discoveryAPI.fetchDiscoveryMovies(currentPage)
            self.movies.append(contentsOf: requestedMovies ?? [])
        }
    }
}
