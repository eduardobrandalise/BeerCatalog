//
//  BeerListViewController.swift
//  BeerCatalog
//
//  Created by Eduardo Brandalise on 29/06/19.
//  Copyright © 2019 Eduardo Brandalise. All rights reserved.
//

import UIKit

enum BeerListEvent: Event {
    case showBeerDetail(_ beer: Beer)
}

class BeerListViewController: UITableViewController {
    
    var viewModel: BeerListViewModel
    let imageRequest = ImageRequest()
    weak var coordinator: Coordinator?
    
    init(viewModel: BeerListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "BeerListCell", bundle: nil), forCellReuseIdentifier: "BeerListCell")
        
        self.viewModel.getBeers { [weak self] in
            DispatchQueue.main.async {
                guard let view = self else { return }
                view.title = "Beers: \(view.viewModel.beers.count)"
                view.tableView.reloadData()
            }
        }
    }
}

// MARK: - Table view delegate and data source

extension BeerListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.beers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as? BeerListCell {
            
            let beer = viewModel.beers[indexPath.row]
            let imageURL = beer.imageURL!
            
            self.imageRequest.getImage(for: cell.beerImageView, from: imageURL)
            cell.nameLabel.text = beer.name
            cell.abvLabel.text = "Alcohol by volume: \(beer.abv)"
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator?.handle(event: BeerListEvent.showBeerDetail(self.viewModel.beers[indexPath.row]))
    }
}
