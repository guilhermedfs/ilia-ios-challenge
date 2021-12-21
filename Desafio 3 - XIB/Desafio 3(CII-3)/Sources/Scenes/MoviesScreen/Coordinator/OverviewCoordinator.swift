//
//  File.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 07/12/21.
//

import UIKit
import RxSwift

class OverviewCoordinator: BaseCoordinator {
    
    var data: MovieResult?
    let bag = DisposeBag()
    
    override func start() {
        let view = MovieDetailsViewController()
        view.coordinator = self
        view.data = data
        view.viewModel = MovieDetailsViewModel()
        navigationController.pushViewController(view, animated: true)
    }
    
   override func finalize() {
       self.parentCoordinator?.removeDependency(coordinator: self)
   }
    
}
