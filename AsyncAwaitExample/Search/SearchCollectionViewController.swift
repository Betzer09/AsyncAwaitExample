//
//  SearchCollectionViewController.swift
//  AsyncAwaitExample
//
//  Created by Austin Betzer on 6/28/22.
//

import UIKit


class SearchCollectionViewController: UICollectionViewController {
    
    private struct Constants {
        static let reuseIdentifier = "movieCell"
    }
    
    var viewModel: SearchCollectionViewModelLogic? = SearchCollectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
    }


    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath)
    
        return cell
    }
}
