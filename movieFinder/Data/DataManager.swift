//
//  DataManager.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 04/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation
import Moya

class DataManager {
    
    var movieApiRepository: MovieRepository!
    var movieCacheRepository: MovieRepository!
    
    var genreAPIRepository: GenreRepository!
    var genreCacheRepository: GenreRepository!
    
    
    init() {
        let api = TmdbAPI()
        self.movieApiRepository = MovieAPIRepository(tmdb: api)
        self.movieCacheRepository = MovieCacheRepository()
        
        self.genreAPIRepository = GenreAPIRepository(tmdb: api)
        self.genreCacheRepository = GenreCacheRepository()
    }
    
    // MARK: Movies
    
    func getMovies(page: Int, onComplete:@escaping (MFResult<[Movie]>) -> Void) {
        
        self.movieApiRepository.fetchMovies(page: page) { (result) in
            switch result {
            case .success(let movies):
                self.movieCacheRepository.saveMovies(movies: movies, clear: page < 2)
                onComplete(.success(object: movies))
            case .failure, .empty:
                self.movieCacheRepository.fetchMovies(page: page, result: { (result) in
                    onComplete(result)
                })
            }
        }
    }

    func getMovies(page: Int, query: String, onComplete:@escaping (MFResult<[Movie]>) -> Void) {
        
        self.movieApiRepository.searchMovies(page: page, query: query) { (result) in
            switch result {
            case .success(let movies):
                onComplete(.success(object: movies))
            case .failure, .empty:
                self.movieCacheRepository.searchMovies(page: page, query: query, result: { (result) in
                    onComplete(result)
                })
            }
        }
    }

    // MARK: Genres
    
    func getGenres(onComplete:@escaping (MFResult<[Genre]>) -> Void) {
        
        self.genreAPIRepository.fetchGenres { (result) in
            switch result {
            case .success(let genres):
                self.genreCacheRepository.saveGenres(genres: genres)
                onComplete(.success(object: genres))
            case .failure, .empty:
                self.genreCacheRepository.fetchGenres(result: { (result) in
                    onComplete(result)
                })
            }
        }
    }
    
}
