//
//  CachedImageView.swift
//  AsyncAwaitExample
//
//  Created by Austin Betzer on 7/18/22.
//

import Foundation
import UIKit

/**
 An image view that handles downloading and loading cached images.
 */

class CachedImageView: UIImageView {
    
    var imageAPI: ImageAPILogic = ImageAPI()
    
    private var imageURL: URL?
    
    func loadImageWithUrl(_ url: URL?, completion: @escaping (Result<UIImage, Error>) -> () = {_ in} ) {
        guard let url = url else {completion(.failure(CachedImageError.noURLProvided)); return}
        
        imageURL = url
        
        DispatchQueue.main.async {
            self.image = nil
            
            // retrieves image if already available in cache
            if let imageFromCache = ImageLoadingManger.shared.imageCache.object(forKey: url as AnyObject) as? UIImage {
                self.image = imageFromCache
                return
            }
            
            self.loadThumbnailFromURL(url, completion: completion)
        }
    }
    
    @available(*, deprecated, renamed: "loadImageWithUrl()")
    func loadImageWithUrl(_ urlString: String?, completion: @escaping (Result<UIImage, Error>) -> () = {_ in} ) {
        guard let urlString = urlString, let url = URL(string: urlString) else {completion(.failure(CachedImageError.noURLProvided)); return}
        
        imageURL = url
        
        DispatchQueue.main.async {
            self.image = nil
            
            // retrieves image if already available in cache
            if let imageFromCache = ImageLoadingManger.shared.imageCache.object(forKey: url as AnyObject) as? UIImage {
                self.image = imageFromCache
                return
            }
            
            self.loadThumbnailFromURL(url, completion: completion)
        }
    }
    
    @discardableResult
    func loadImageWithUrl(_ urlString: String?) async throws -> UIImage {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return UIImage()
        }
        
        DispatchQueue.main.async {
            self.image = nil
        }
        
        imageURL = url
        
        return try await withCheckedThrowingContinuation({ continuation in
            loadThumbnailFromURL(url) { result in
                continuation.resume(with: result)
            }
        })
    }
    
    
    private func loadThumbnailFromURL(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> ()) {
        Task(priority: .background) {
            do {
                let data = try await imageAPI.fetchImageWith(backdropPath: url.absoluteString)
                guard let imageToCache = UIImage(data: data) else {
                    throw CachedImageError.unableToParseImageData
                }
                
                DispatchQueue.main.async {
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
                }
                
                ImageLoadingManger.shared.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                
                completion(.success(imageToCache))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    enum CachedImageError: Error {
        case noURLProvided
        case unableToParseImageData
    }
    
}
