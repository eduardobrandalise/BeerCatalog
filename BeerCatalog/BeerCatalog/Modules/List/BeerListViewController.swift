//
//  BeerListViewController.swift
//  BeerCatalog
//
//  Created by Eduardo Brandalise on 29/06/19.
//  Copyright © 2019 Eduardo Brandalise. All rights reserved.
//

import UIKit

class BeerListViewController: UITableViewController {
    
    var viewModel: BeerListViewModel
    
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
        
        self.viewModel.getBeers { [weak self] (beers, error) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - Table view delegate and data source

extension BeerListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.beers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.beers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as? BeerListCell {
            let beer = viewModel.beers[indexPath.row]
            
            cell.beerImageView = UIImageView()
            cell.nameLabel.text = beer.name
            cell.taglineLabel.text = beer.tagline
            
            return cell
        }
        return UITableViewCell()
    }
}
