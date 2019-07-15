//
//  Coordinator.swift
//  BeerCatalog
//
//  Created by Eduardo Brandalise on 29/06/19.
//  Copyright © 2019 Eduardo Brandalise. All rights reserved.
//

import Foundation

protocol Event {}

protocol Coordinator: class {
    func start()
    func handle(event: Event)
}
