//
//  UIImageExtensions.swift
//  BeerCatalog
//
//  Created by Eduardo Brandalise on 13/07/19.
//  Copyright © 2019 Eduardo Brandalise. All rights reserved.
//

import UIKit

extension UIImage {
    var data: Data? {
        if let data = self.jpegData(compressionQuality: 1.0) {
            return data
        } else {
            return nil
        }
    }
}

extension Data {
    var image: UIImage? {
        if let image = UIImage(data: self) {
            return image
        } else {
            return nil
        }
    }
}

extension UIImageView {
    
    /// A UIImageView extension to download an image from a given URL.
    ///
    /// - Parameters:
    ///   - URL: a URL to be used to fetch the image.
    ///   - contentMode: the content mode the UIView should follow in order to adjust the image.
    func downloadImageFrom(URL: URL, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            DispatchQueue.main.async {
                self.contentMode = contentMode
                if let data = data {
                    self.image = data.image
                }
            }
        }.resume()
    }
}
