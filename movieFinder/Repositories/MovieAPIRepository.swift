//
//  MovieCacheRepository.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 18/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation
import Moya


public class MovieAPIRepository: MovieRepository {
    
    private let tmdb:TmdbProvider
    private var language:String!
    
    public init(tmdb: TmdbProvider) {
        self.tmdb = tmdb
        let langStr = Locale.current.languageCode
        self.language = langStr
    }
    
    public func fetchMovies(page: Int, result:@escaping (MFResult<[Movie]>) -> Void) {
        self.tmdb.movie.request(.list(apiKey: Constants.API.apiKey, language: self.language, page: page)) { (moyaResult) in
            switch moyaResult {
            case .success(let response):
                if let arrayMovies = response.mapMovies() {
                    result(.success(object: arrayMovies))
                }else{
                    result(.empty)
                }
            case .failure(let error):
                result(.failure(error: error))
            }
        }
    }
    
    public func searchMovies(page: Int, query: String,  result:@escaping (MFResult<[Movie]>) -> Void) {
        self.tmdb.movie.request(.search(apiKey: Constants.API.apiKey, language: self.language,page: page, query: query)) { (moyaResult) in
            switch moyaResult {
            case .success(let response):
                if let arrayMovies = response.mapMovies() {
                    result(.success(object: arrayMovies))
                }else{
                    result(.empty)
                }
            case .failure(let error):
                result(.failure(error: error))
            }
        }
    }
    
    public func saveMovies(movies:[Movie], clear:Bool) {
        
    }
}
