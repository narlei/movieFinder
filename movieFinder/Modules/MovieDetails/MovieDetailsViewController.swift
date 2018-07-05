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
    
    var movie:Movie!

    // MARK: Actions
    
    @IBAction func actionButtonBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let strUrl = "\(Constants.API.imageBaseUrl)500/\(movie.posterPath!)"
        self.imageViewCover.sd_setImage(with: URL(string:strUrl)) { (image, error, type, url) in
            let imageSized = image!.resizeImage(newWidth: self.view.frame.size.width)
            self.constraintImageHeight.constant = imageSized.size.height
        }
        self.labelTitle.text = movie.title
        self.labelDescription.text = movie.overview
        
        self.labelAdditional.text = "Lançamento: \(movie.releaseDate.toDateFormat(format: "dd 'de' MMMM 'de' yyyy"))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   


}
