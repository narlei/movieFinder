//
//  MovieListInteractor.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 05/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation
import Moya
class MovieListInteractor: MovieListUseCase {
    
    weak var output: MovieListInteractorOutput!
    let api = TmdbAPI()
    
    func searchMovie(query: String, page: Int) {
        api.movie.request(.search(apiKey: Constants.API.apiKey, language: Constants.API.language,page: page, query: query)) { (result) in
            switch result {
            case .success(let response):
                if let arrayMovies = response.mapMovies() {
                    self.output.moviesFetched(movies: arrayMovies)
                    return
                }
                self.output.moviesFetchFailed()
            case .failure( _):
                self.output.moviesFetchFailed()
            }
        }
    }
    
    func fetchMovies(page: Int) {
        DataManager.shared.getMovies(page: page) { (result) in
            switch result {
            case .success(let movies):
                self.output.moviesFetched(movies: movies)
            case .failure( _):
                self.output.moviesFetchFailed()
            case .emtpy:
                self.output.moviesFetchFailed()
            }
        }
    }
    
}
