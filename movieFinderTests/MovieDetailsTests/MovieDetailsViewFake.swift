//
//  MovieDetailsInteractorFake.swift
//  movieFinderTests
//
//  Created by Narlei A Moreira on 06/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation

class MovieDetailsViewFake:MovieDetailsView {
    var presenter: MovieDetailsPresentation!
    var isDetailsShowed = false
    var arrayGenresShowed:[Genre]?
    
    func showDetails(forMovie movie: Movie) {
        self.isDetailsShowed = true
    }
    
    func showGenres(genres: [Genre]?) {
        self.arrayGenresShowed = genres
    }
    

}
