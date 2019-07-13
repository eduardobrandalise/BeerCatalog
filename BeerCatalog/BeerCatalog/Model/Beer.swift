//
//  Beer.swift
//  BeerCatalog
//
//  Created by Eduardo Brandalise on 29/06/19.
//  Copyright © 2019 Eduardo Brandalise. All rights reserved.
//

import UIKit

struct Beer: Decodable {
    let id: Int
    let name: String
    let tagline: String
    let imageURL: URL?
    var image: UIImage? = nil
    let abv: Double
    let ibu: Double?
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name, tagline, abv, ibu, description
        case imageURL = "image_url"
    }
}
