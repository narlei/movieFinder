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
    
    var currentPage = 0
    var isSearching = false
    var searchQuery = ""
    
    var movies:[Movie] = [] {
        didSet {
            view?.showMoviesData(movies)
        }
    }
    
    func viewDidLoad() {
        self.currentPage = 1
        self.interactor.fetchMovies(page: self.currentPage)
    }
    
    func reload() {
        self.currentPage = 1
        self.isSearching = false
        self.interactor.fetchMovies(page: self.currentPage)
        self.view?.hideSearchBar()
    }
    
    func didOpenSearchMovie() {
        view?.showSearchBar()
    }
    
    func didCloseSearchMovie() {
        view?.hideSearchBar()
    }
    
    func didSearchMovie(query: String) {
        self.currentPage = 1
        self.isSearching = true
        self.searchQuery = query
        self.interactor.searchMovie(query: query, page: self.currentPage)
    }
    
    func didSelectMovie(movie: Movie) {
        router.presentDetails(forMovie: movie)
    }
    
    func didLoadNexPage() {
        self.currentPage += 1
        if self.isSearching {
            self.interactor.searchMovie(query: self.searchQuery, page: self.currentPage)
        }else{
            self.interactor.fetchMovies(page: self.currentPage)
        }
    }
}

extension MovieListPresenter: MovieListInteractorOutput {
    func moviesFetched(movies: [Movie]) {
        if self.currentPage > 1 {
            self.movies.append(contentsOf: movies)
        }else{
            self.movies = movies
        }
    }
    
    func moviesFetchFailed() {
        self.view?.showNoContentScreen()
    }
}
