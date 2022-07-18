//
//  DiscoveryMovieCollectionViewCell.swift
//  AsyncAwaitExample
//
//  Created by Austin Betzer on 7/18/22.
//

import UIKit

class DiscoveryMovieCollectionViewCell: UICollectionViewCell {
    static let identifer = "DiscoveryMovieCollectionViewCell"
    
    @IBOutlet weak var imageView: CachedImageView!
    
    var movie: DiscoveryMovie? {
        didSet {
            configureView()
        }
    }
    
    private func configureView() {
        guard let movie = movie else {
            return
        }

        let url = URL(string: "https://image.tmdb.org/t/p/w780\(movie.backdropPath)")
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.imageView.loadImageWithUrl(movie.backdropPath)
        }
    }
    
}
