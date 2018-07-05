//
//  MovieDetailsPresenter.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 05/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation

class MovieDetailsPresenter : MovieDetailsPresentation {
    
    weak var view: MovieDetailsView?
    var wireframe: MovieDetailsWireframe!
    var movie: Movie!
    
    func viewDidLoad() {
        view?.showDetails(forMovie: movie)
    }
}
