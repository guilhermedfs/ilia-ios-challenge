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

protocol ChangeCollectionColor {
    func changeColor(color: String)
}
class MoviesViewController: UIViewController {
    
    var moviesViewModel: MoviesViewModel!
    var coordinator: MainCoordinator?
    let passData = PublishSubject<MovieResult>()
    var bag: DisposeBag!
    var movies: [MovieResult]!
    var changeMoviesColor = ConfigViewModel()
    let defaults = UserDefaults.standard


    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavBarTitle()
        setNavBarConfigItem()
        let nibCell = UINib(nibName: "MoviesCollectionViewCell", bundle: nil)
        moviesCollectionView.register(nibCell, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        moviesViewModel.fetchData()
        bindData()
        let defaultColor = defaults.object(forKey: "UserColor") as? String ?? "White"
        moviesCollectionView.backgroundColor = Colors.colors[defaultColor]
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
    
    func setNavBarTitle () {
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString(AtributtesIDs.movieLabelID, comment: "Movie Label")
    }
    
    func setNavBarConfigItem () {
        let item = UIButton(type: .custom)
        item.setImage(.actions, for: .normal)
        item.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        item.addTarget(self, action: #selector(onTapConfig), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: item)
        self.navigationItem.setRightBarButton(item1, animated: true)
    }
    
    @objc func onTapConfig() {
        coordinator?.showConfigsScreen(delegate: self)
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
        coordinator?.showMovieDetails(data: movies[indexPath.item])
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

extension MoviesViewController: ChangeCollectionColor {
    func changeColor(color: String) {
        moviesCollectionView.backgroundColor = Colors.colors[color]
        defaults.set(color, forKey: "UserColor")
    }
}
