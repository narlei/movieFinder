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
    @IBOutlet weak var labelRelease: UILabel!
    @IBOutlet weak var labelVoteStars: UILabel!
    @IBOutlet weak var labelVoteAvg: UILabel!
    
    
    func initialize(movie:Movie) {
        if let path = movie.posterPath {
            let strUrl = "\(Constants.API.imageBaseUrl)200/\(path)"
            self.imageViewCover.sd_setImage(with: URL(string:strUrl), completed: nil)
            self.imageViewCover.layer.shadowColor = UIColor.black.cgColor
            self.imageViewCover.layer.shadowOffset = CGSize(width: 1, height: 1)
            self.imageViewCover.layer.shadowOpacity = 0.5
            self.imageViewCover.layer.shadowRadius = 5
        }
        self.labelTitle.text = movie.title
        self.labelRelease.text = "Lançamento: \(movie.releaseDate.toDateFormat(format: "dd 'de' MMMM 'de' yyyy"))"
        if movie.voteAverage > 0 {
            self.labelVoteAvg.text = String(movie.voteAverage)
            let rate = Int(movie.voteAverage / 2)
            self.labelVoteStars.text = String.init(repeating: "⭐️", count: rate)
        }else{
            self.labelVoteAvg.text = ""
            self.labelVoteStars.text = "Sem avaliações"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
