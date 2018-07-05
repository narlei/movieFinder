//
//  MovieListPresenter.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 05/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation

class MovieListPresenter: MovieListPresentation {
    var view: MovieListView?
    var interactor: MovieListUseCase!
    var router: MovieListWireframe!
    
    var totalPages = 0
    
    var movies:[Movie] = [] {
        didSet {
            view?.showMoviesData(movies)
        }
    }
    
    func viewDidLoad() {
        self.interactor.fetchMovies(page: 1)
    }
    
    func reload() {
        self.interactor.fetchMovies(page: 1)
    }
    
    func didOpenSearchMovie() {
        view?.showSearchBar()
    }
    
    func didCloseSearchMovie() {
        view?.hideSearchBar()
    }
    
    func didSearchMovie(query: String) {
        self.interactor.fetchMovies(page: 1)
    }
    
    func didSelectMovie(movie: Movie) {
        router.presentDetails(forMovie: movie)
    }
}

extension MovieListPresenter: MovieListInteractorOutput {
    func moviesFetched(movies: [Movie]) {
        self.movies = movies
    }
    
    func moviesFetchFailed() {
        self.view?.showNoContentScreen()
    }
}
