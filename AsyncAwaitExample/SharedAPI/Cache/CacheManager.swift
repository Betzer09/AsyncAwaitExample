//
//  NSCache.swift
//  AsyncAwaitExample
//
//  Created by Austin Betzer on 7/18/22.
//

import Foundation

class ImageLoadingManger {
    static let shared = ImageLoadingManger()
    
    let imageCache = NSCache<AnyObject, AnyObject>()
}
