//
//  BaseCoordinator.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 09/12/21.
//

import UIKit

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, childCoordinators: [Coordinator]) {
        self.navigationController = navigationController
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        
    }
    
    func addDependency(coordinator: Coordinator?) {
        guard let child = coordinator else {
            return
        }
        childCoordinators.append(child)
    }
    
    func removeDependency(coordinator: Coordinator?) {
        guard let coordinator = coordinator else {
            return
        }
        guard let index = childCoordinators.firstIndex(where: { $0 === coordinator }) else {
            return
        }
        
        childCoordinators.remove(at: index)
    }
    
    func finalize() {
        self.removeDependency(coordinator: self)
    }
}
