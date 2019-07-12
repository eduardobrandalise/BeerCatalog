//
//  BeerListViewModel.swift
//  BeerCatalog
//
//  Created by Eduardo Brandalise on 29/06/19.
//  Copyright © 2019 Eduardo Brandalise. All rights reserved.
//

import Foundation

class BeerListViewModel {
    
    var beers: [Beer] = []
    
    typealias BeerRetrieved = ([Beer], BeerError?) -> Void
    
    func getBeers(completion: @escaping(BeerRetrieved)) {
        let beerRequest = BeerRequest()
        beerRequest.getBeers { [weak self] beerResult in
            switch beerResult {
            case .failure(let error):
                print(error)
            case .success(let beers):
                self?.beers = beers
                completion(beers, nil)
            }
        }
    }
}
