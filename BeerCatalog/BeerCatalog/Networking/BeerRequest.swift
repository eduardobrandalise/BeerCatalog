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
    
    
    /// This method fetches a collection of objects of the type Beer from the API. In a completion handler, it returns a BeerResult which may have two results: a failure that passes a BeerError or a success which passes a collection of the type Beer.
    ///
    /// - Parameter completion: Returns the BeerResult with either a failure or success result.
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
