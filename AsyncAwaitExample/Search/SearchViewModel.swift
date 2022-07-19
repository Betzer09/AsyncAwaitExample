//
//  SearchViewModel.swift
//  AsyncAwaitExample
//
//  Created by Austin Betzer on 7/19/22.
//

import Foundation


class SearchViewModel {
    let api: FindMoviesAPILogic = FindMoviesAPI()
    
    @Published var movies: [DiscoveryMovie] = []
    
    func fetchMovies() {
        
    }
    
}
