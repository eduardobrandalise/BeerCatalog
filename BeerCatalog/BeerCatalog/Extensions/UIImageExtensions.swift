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
