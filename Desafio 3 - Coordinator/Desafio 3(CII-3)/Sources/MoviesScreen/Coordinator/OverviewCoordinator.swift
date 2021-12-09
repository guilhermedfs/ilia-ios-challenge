//
//  File.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 07/12/21.
//

import UIKit

class OverviewCoordinator: BaseCoordinator {
    
    var data: MovieResult?
    
    override func start() {
        let view = MovieDetailsViewController.instantiate()
        view.coordinator = self
        view.data = data
        view.viewModel = MovieOverviewViewModel()
        navigationController.pushViewController(view, animated: true)
    }
    
    override func finalize() {
        self.removeDependency(coordinator: self)
    }
}
