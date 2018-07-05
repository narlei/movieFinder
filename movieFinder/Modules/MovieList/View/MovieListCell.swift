//
//  MovieListCell.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 04/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelRelease: UILabel!
    
    
    func initialize(movie:Movie) {
        let strUrl = "\(Constants.API.imageBaseUrl)200/\(movie.posterPath!)"
        self.imageViewCover.sd_setImage(with: URL(string:strUrl)) { (image, error, type, url) in
            
        }
        self.labelTitle.text = movie.title
        self.labelRelease.text = "Lançamento: \(movie.releaseDate.toDateFormat(format: "dd 'de' MMMM 'de' yyyy"))"
        
        let arrayGenres = DataManager.shared.uncacheGenres()
        let array = arrayGenres?.filter({ (genre) -> Bool in
            if movie.genreIds.contains(genre.id) {
                return true
            }
            return false
        })
        
        let genres = array?.map({ (genre) -> String in
            return genre.name
        })
        self.labelGenre.text = genres?.joined(separator: ",")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
