//
//  movieDetailsViewController.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme Silva on 25/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var movieAverageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var data: MovieResult!
    var viewModel: MovieDetailsViewModel!
    weak var coordinator: OverviewCoordinator?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        movieTitleLabel.text = data?.title

        movieDetailsLabel.text = data?.overview == "" ? NSLocalizedString(AtributtesIDs.noSynopsisID, comment: "No synopsis") : data?.overview
        
        let formatString = NSLocalizedString(AtributtesIDs.releaseDateID, comment: "Release date")
        
        releaseDateLabel.text = String.localizedStringWithFormat(formatString, viewModel.formatDate(date: data?.releaseDate ?? ""))
        
        posterPath()
        
        voteString()
        
        let defaultColor = defaults.object(forKey: "UserColor") as? String ?? "White"
        view.backgroundColor = Colors.colors[defaultColor]
        
    }
    
    func voteString () {
        let voteAverage = data.voteAverage
        let formatString = NSLocalizedString(AtributtesIDs.voteAverageID, comment: "Vote Average")
        let voteString = String.localizedStringWithFormat(formatString, voteAverage!)
        let attributedString = NSMutableAttributedString.init(string: voteString)
        let range = (voteString as NSString).range(of: String(voteAverage ?? 0))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: viewModel.getTextColor(average: voteAverage ?? 0), range: range)
        movieAverageLabel.attributedText = attributedString
        movieAverageLabel.isUserInteractionEnabled = false
    }
    
    func posterPath () {
        guard let posterPath = data?.posterPath else {
            return
        }
        
        viewModel?.loadImage(url: posterPath){
            (datas) in
                self.movieImageView.image = UIImage(data: datas ?? Data())
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if self.isMovingFromParent {
            coordinator?.finalize()
        }
        print(#function)
    }

    deinit {
        print("ARC is deallocating memory at MovieDetailsViewController")
    }
}


