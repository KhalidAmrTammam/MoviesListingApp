//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Khalid Amr on 23/07/2025.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var isFavorite = false {
        didSet {
            let image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            favoriteButton.setImage(image, for: .normal)
        }
    }
    private var movie: Movies?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
    }
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        isFavorite.toggle()
        if let id = movie?.id {
            FavoriteMoviesStorage.toggleFavorite(movieId: id)
        }
    }
    
    func configure(with movie: Movies) {
        self.movie = movie
        titleLabel.text = movie.title
        ratingLabel.text = "★ \(movie.vote_average)"
        releaseDateLabel.text = "Released: \(movie.release_date)"
        isFavorite = FavoriteMoviesStorage.isFavorite(movieId: movie.id)
        
        let base = "https://image.tmdb.org/t/p/w200"
        if let url = URL(string: base + movie.poster_path) {
            posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        }
    }
}
