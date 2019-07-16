//
//  ImageRequest.swift
//  BeerCatalog
//
//  Created by Eduardo Brandalise on 16/07/19.
//  Copyright © 2019 Eduardo Brandalise. All rights reserved.
//

import UIKit

struct ImageRequest {
    
    /// This method gets an image from a given URL and sets it in the  UIImageView passed in the parameters. First it tries to retrieve it from the local image cache but if it fails, then it fetches from the URL.
    ///
    /// - Parameters:
    ///   - imageView: A reference to the View to which the image is going to be attributed.
    ///   - URL: The URL from where the image is going to be fetched.
    func getImage(for imageView: UIImageView, from URL: URL) {
        
        let URLString = URL.absoluteString as NSString
        
        if let image = ImageCache.shared.tryToRetrieveFromCache(imageKey: URLString) {
            imageView.image = image
        } else {
            self.downloadImage(for: imageView, from: URL) { image in
                ImageCache.shared.cache(image, forKey: URLString)
            }
        }
    }
    
    
    /// Fetches an image from a given URL and attibutes it to the UIImageView passed in the parameters.
    ///
    /// - Parameters:
    ///   - imageView: The View to which the fetched image is going to be attibuted.
    ///   - URL: The URL from where the image is going to be fetched.
    ///   - completion: An optional completion handler that passes the image fetched in case of a successful attempt.
    private func downloadImage(for imageView: UIImageView, from URL: URL, completion: ((UIImage) -> Void)?) {
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            DispatchQueue.main.async {
                if let image = data?.image {
                    imageView.image = image
                    completion?(image)
                }
            }
        }.resume()
    }
}
