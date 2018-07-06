//
//  MovieDetailsRouter.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 05/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsRouter: MovieDetailsWireframe {
    
    static func assembleModule(movie: Movie) -> UIViewController {
        let view = UIStoryboard(name: "MovieDetails", bundle: nil).instantiateInitialViewController() as! MovieDetailsViewController
        let presenter = MovieDetailsPresenter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = MovieDetailsInteractor()
        presenter.movie = movie
        presenter.interactor.output = presenter
        
        return view
    }
}
