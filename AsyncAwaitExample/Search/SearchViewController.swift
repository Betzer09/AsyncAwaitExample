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
    @IBOutlet weak var searchTextField: UISearchBar!
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
        
        searchTextField.searchTextField.textPublisher()
            .debounce(for: 0.4, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                print("UITextField.text changed to: \(value)")
            })
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

extension UITextField {
  func textPublisher() -> AnyPublisher<String, Never> {
      NotificationCenter.default
          .publisher(for: UITextField.textDidChangeNotification, object: self)
          .map { ($0.object as? UITextField)?.text  ?? "" }
          .eraseToAnyPublisher()
  }
}
