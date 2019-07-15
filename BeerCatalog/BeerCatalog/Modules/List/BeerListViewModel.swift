//
//  BeerListViewModel.swift
//  BeerCatalog
//
//  Created by Eduardo Brandalise on 29/06/19.
//  Copyright © 2019 Eduardo Brandalise. All rights reserved.
//

import UIKit

class BeerListViewModel {
    
    var beers: [Beer] = []
    let beerRequest = BeerRequest()
    
    typealias BeerRetrieved = () -> Void
    
    func getBeers(completion: @escaping(BeerRetrieved)) {
        self.beerRequest.getBeers { [weak self] beerResult in
            
            switch beerResult {
            case .failure(let error):
                print(error)
                
            case .success(let beers):
                self?.beers = beers
                completion()
            }
        }
    }
}

