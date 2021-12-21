//
//  ConfigsCoordinator.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 21/12/21.
//

import Foundation

class ConfigsCoordinator: BaseCoordinator {
    var delegate: ChangeCollectionColor?
    
    override func start() {
        let view = ConfigScreenViewController()
        view.delegate = delegate
        navigationController.pushViewController(view, animated: true)
    }
    
   override func finalize() {
       self.parentCoordinator?.removeDependency(coordinator: self)
   }
}
