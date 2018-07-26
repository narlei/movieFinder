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
    var interactor: MovieDetailsUseCase!
    var movie: Movie!
    
    func viewDidLoad() {
        view?.showDetails(forMovie: movie)
        self.loadGenre(movie: movie)
    }
    
    func loadGenre(movie: Movie) {
        self.movie = movie
        self.interactor.fetchGenres()
    }
}

extension MovieDetailsPresenter: MovieDetailsInteractorOutput {
    func genresFetched(genres: [Genre]) {
        let array = genres.filter({[weak self] (genre) -> Bool in
            guard let weakSelf = self else{
                return false
            }
            if weakSelf.movie.genreIds.contains(genre.id) {
                return true
            }
            return false
        })
        self.view?.showGenres(genres: array)
    }
    
    func genresFetchFailed() {
        self.view?.showGenres(genres: nil)
    }
}
