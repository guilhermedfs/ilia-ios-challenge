//
//  MoviesCollectionViewCell.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 17/12/21.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    var dataImage: MovieDetailsViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func onBind(data: MovieResult) {
        movieNameLabel.text = data.title
        
        guard let imagePoster = data.posterPath else {
            return
        }
        dataImage.loadImage(url: dataImage.setImageLink(url: imagePoster)) { (data) in
            self.movieImage.image = UIImage(data: data!)
        }
    }
}
