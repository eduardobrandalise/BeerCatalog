//
//  AppCoordinator.swift
//  BeerCatalog
//
//  Created by Eduardo Brandalise on 29/06/19.
//  Copyright © 2019 Eduardo Brandalise. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let beerListView = BeerListViewController(viewModel: BeerListViewModel())
        
        self.window?.rootViewController = beerListView
    }
}
