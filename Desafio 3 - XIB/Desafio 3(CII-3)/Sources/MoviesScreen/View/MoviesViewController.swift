//
//  MoviesViewController.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Silva on 25/11/21.
//

import UIKit
import Moya
import RxCocoa
import RxSwift

class MoviesViewController: UIViewController {
    
    var moviesViewModel: MoviesViewModel!
    var coordinator: MainCoordinator?
    let passData = PublishSubject<MovieResult>()
    var bag: DisposeBag!
    var movies: [MovieResult]!

    @IBOutlet weak var moviesNavigation: UINavigationItem!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        moviesNavigation.title = NSLocalizedString("mv_label", comment: "Movie Label")
        let nibCell = UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
        moviesCollectionView.register(nibCell, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        moviesViewModel.fetchData()
        bindData()
    }
    
    func reloadData() {
        self.moviesCollectionView.reloadData()
    }
    
    func bindData() {
        moviesViewModel.movies.subscribe(onNext: { [weak self] movies in
            self?.movies.append(contentsOf: movies)
            self?.reloadData()
        }).disposed(by: bag)
        moviesViewModel.changePage.subscribe { _ in
            self.moviesViewModel.fetchData()
        }.disposed(by: bag)
    }
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        cell.dataImage = MovieDetailsViewModel()
        cell.onBind(data: movies[indexPath.item])
        
        // Loads more pages
        if indexPath.row == self.movies.count - 1 {
            moviesViewModel.loadPages()
        }
        
        return cell
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 2   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: 300)
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.seeMovieDetails(data: movies[indexPath.item])
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self, comment: self)
    }
}

