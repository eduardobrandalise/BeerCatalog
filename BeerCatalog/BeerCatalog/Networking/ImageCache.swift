//
//  ImageCache.swift
//  BeerCatalog
//
//  Created by Eduardo Brandalise on 16/07/19.
//  Copyright © 2019 Eduardo Brandalise. All rights reserved.
//

import UIKit

class ImageCache: NSCache<NSString, UIImage>, NSCacheDelegate {

    static let shared = ImageCache()
    
    let cache = NSCache<NSString, UIImage>()
    
    func tryToRetrieveFromCache(imageKey: NSString) -> UIImage? {
        if let cachedImage = cache.object(forKey: imageKey) {
            return cachedImage
        } else {
            return nil
        }
    }
    
    func cache(_ image: UIImage, forKey key: NSString) {
        self.cache.setObject(image, forKey: key)
    }
}
