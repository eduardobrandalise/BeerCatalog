//
//  BeerRequest.swift
//  BeerCatalog
//
//  Created by Eduardo Brandalise on 11/07/19.
//  Copyright © 2019 Eduardo Brandalise. All rights reserved.
//

import UIKit

enum BeerError: Error {
    case dataNotAvailable
    case dataNotProcessed
}

struct BeerRequest {
    let resourceString = "https://api.punkapi.com/v2/beers"
    let resourceURL: URL
    
    typealias BeerResult = Result<[Beer], BeerError>
    
    init() {
        guard let resourceURL = URL(string: self.resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getBeers(completion: @escaping(BeerResult) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: self.resourceURL) { (data, response, error) in
            
            guard let jsonData = data else {
                completion(.failure(.dataNotAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let beers = try decoder.decode([Beer].self, from: jsonData)
                completion(.success(beers))
                
            } catch {
                 completion(.failure(.dataNotProcessed))
            }
        }
        dataTask.resume()
    }
}
