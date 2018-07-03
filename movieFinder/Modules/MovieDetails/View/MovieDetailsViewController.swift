//
//  MovieDetailsViewController.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 04/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import UIKit
import SDWebImage


class MovieDetailsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var constraintImageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelAdditional: UILabel!
    
    // MARK: Properties
    
    var presenter: MovieDetailsPresentation!
    
    // MARK: Actions
    
    @IBAction func actionButtonBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension MovieDetailsViewController: MovieDetailsView {
    func showGenres(genres: [Genre]?) {
        let arrayGenres = genres?.map({ (genre) -> String in
            return genre.name
        })
        let strGenres = arrayGenres?.joined(separator: ", ") ?? ""
        
        self.labelAdditional.text = "\(self.labelAdditional.text!)\n\n\(R.string.localizable.genres()): \(strGenres)"
    }
    
    func showDetails(forMovie movie: Movie) {
        if let posterPath = movie.posterPath {
            let strUrl = "\(Constants.API.imageBaseUrl)500/\(posterPath)"
            self.imageViewCover.sd_setImage(with: URL(string:strUrl)) { [weak self] (image, error, type, url) in
                guard let imageDownloaded = image, let weakSelf = self else{
                    return
                }
                let imageSized = imageDownloaded.resizeImage(newWidth: weakSelf.view.frame.size.width)
                weakSelf.constraintImageHeight.constant = imageSized.size.height
            }
        } else {
            self.imageViewCover.image = UIImage()
        }
        self.labelTitle.text = movie.title
        self.labelDescription.text = movie.overview
        
        self.labelAdditional.text = "\(R.string.localizable.release_date()): \(movie.releaseDate.toDateFormat(format: R.string.localizable.release_date_format()))"
    }
    
    
}
