//
//  AppCoordinator.swift
//  BeerCatalog
//
//  Created by Eduardo Brandalise on 29/06/19.
//  Copyright © 2019 Eduardo Brandalise. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var window: UIWindow?
    
    lazy var rootViewController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewModel = BeerListViewModel()
        let beerListView = BeerListViewController(viewModel: viewModel)
        beerListView.coordinator = self
        
        self.rootViewController.setViewControllers([beerListView], animated: true)
        self.window?.rootViewController = self.rootViewController
    }
    
    private func showDetailViewController(beer: Beer) {
        let viewModel = BeerDetailViewModel(beer: beer)
        let viewController = BeerDetailViewController(viewModel: viewModel)
        
        self.rootViewController.pushViewController(viewController, animated: true)
    }
    
    func handle(event: Event) {
        switch event {
        case BeerListEvent.showBeerDetail(beer: let beer):
            self.showDetailViewController(beer: beer)
        default: ()
        }
    }
}
