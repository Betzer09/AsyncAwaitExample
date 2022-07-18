//
//  SearchCollectionViewController.swift
//  AsyncAwaitExample
//
//  Created by Austin Betzer on 6/28/22.
//

import UIKit
import Combine


class SearchCollectionViewController: UICollectionViewController {
    
    var viewModel = SearchCollectionViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
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
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoveryMovieCollectionViewCell.identifer, for: indexPath) as! DiscoveryMovieCollectionViewCell
        cell.movie = viewModel.movies[indexPath.row]
        return cell
    }
    
    
}
