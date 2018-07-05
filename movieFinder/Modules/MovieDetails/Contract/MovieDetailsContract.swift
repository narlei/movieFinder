//
//  MovieDetailsContract.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 05/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import UIKit

protocol MovieDetailsView: class {
    var presenter: MovieDetailsPresentation! { get set }
    
    func showDetails(forMovie movie: Movie)
}

protocol MovieDetailsPresentation: class {
    var view: MovieDetailsView? { get set }
    
    func viewDidLoad()
}

protocol MovieDetailsWireframe: class {
    static func assembleModule(movie: Movie) -> UIViewController
}
