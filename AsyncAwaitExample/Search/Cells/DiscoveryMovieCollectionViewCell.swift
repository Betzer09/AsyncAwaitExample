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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var movie: DiscoveryMovie? {
        didSet {
            configureView()
        }
    }
    
    private func configureView() {
        guard let movie = movie else {
            return
        }
        
        imageView.loadImageWithUrl(movie.backdropPath)
        titleLabel.text = movie.title
        detailLabel.text = movie.overview
    }
    
}
