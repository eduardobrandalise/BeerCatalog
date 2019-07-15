//
//  BeerDetailViewController.swift
//  BeerCatalog
//
//  Created by Eduardo Brandalise on 15/07/19.
//  Copyright © 2019 Eduardo Brandalise. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    var viewModel: BeerDetailViewModel
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .top
        
        return stackView
    }()
    
    init(viewModel: BeerDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = self.viewModel.beer.name
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)
        
        self.configureConstraints()
        self.configureViews()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            ])
    }
    
    private func configureViews() {
        self.configureImageView()
        self.configureNameView()
        self.configureTaglineView()
        self.configureAbvView()
        self.configureIbuView()
        self.configureDescriptionView()
    }
    
    private func configureImageView() {
        let beer = self.viewModel.beer
        let containerView = UIView()
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.downloadImageFrom(URL: (beer.imageURL)!, contentMode: .scaleAspectFit)
        
        stackView.addArrangedSubview(containerView)
        containerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1),
            
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            ])
    }
    
    private func configureNameView() {
        let nameView = InformationView()
        nameView.titleLabel.text = "Name:"
        nameView.descriptionLabel.text = self.viewModel.beer.name
        self.stackView.addArrangedSubview(nameView)
    }
    
    private func configureTaglineView() {
        let taglineView = InformationView()
        taglineView.titleLabel.text = "Tagline:"
        taglineView.descriptionLabel.text = self.viewModel.beer.tagline
        self.stackView.addArrangedSubview(taglineView)
    }
    
    private func configureAbvView() {
        let abvView = InformationView()
        abvView.titleLabel.text = "Alcohol by volume:"
        abvView.descriptionLabel.text = "\(self.viewModel.beer.abv)"
        self.stackView.addArrangedSubview(abvView)
    }
    
    private func configureIbuView() {
        if let ibu = self.viewModel.beer.ibu {
            let ibuView = InformationView()
            ibuView.titleLabel.text = "Bitterness scale:"
            ibuView.descriptionLabel.text = "\(ibu)"
            self.stackView.addArrangedSubview(ibuView)
        }
    }
    
    private func configureDescriptionView() {
        let descriptionView = InformationView()
        descriptionView.titleLabel.text = "Description:"
        descriptionView.descriptionLabel.text = self.viewModel.beer.description
        self.stackView.addArrangedSubview(descriptionView)
    }
}
