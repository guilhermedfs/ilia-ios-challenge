//
//  MainCoordinator.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 06/12/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class MainCoordinator: BaseCoordinator {
    
    override func start() {
        let vc = MoviesViewController.instantiate()
        vc.coordinator = self
        vc.moviesViewModel = MoviesViewModel(movieData: MovieData(maxPage: 0, currentPage: 1))
        vc.movies = []
        vc.bag = DisposeBag()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func seeMovieDetails(data: MovieResult?) {
        let child = OverviewCoordinator(navigationController: navigationController, childCoordinators: childCoordinators)
        addDependency(coordinator: child)
        child.data = data
        child.parentCoordinator = self
        child.start()
    }
    
    deinit {
        print("coordinator clean")
    }
}
