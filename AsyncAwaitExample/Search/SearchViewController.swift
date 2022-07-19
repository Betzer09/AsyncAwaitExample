//
//  SearchViewController.swift
//  AsyncAwaitExample
//
//  Created by Austin Betzer on 7/19/22.
//

import Foundation
import UIKit
import Combine

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let viewModel = SearchViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinders()
        viewModel.fetchMovies()
        
    }
    
    private func setupBinders() {
        viewModel.$movies
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else {
                    return
                }
                
                self.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoveryMovieCollectionViewCell.identifer, for: indexPath) as! DiscoveryMovieCollectionViewCell
        cell.movie = viewModel.movies[indexPath.row]
        return cell
    }
}
