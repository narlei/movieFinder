//
//  GenreAPIRepository.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 18/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation


import Moya


public class GenreAPIRepository: GenreRepository {
    
    private let tmdb:TmdbProvider
    private var language:String!
    
    public init(tmdb: TmdbProvider) {
        self.tmdb = tmdb
        let langStr = Locale.current.languageCode
        self.language = langStr
    }
    
    public func fetchGenres(result: @escaping (MFResult<[Genre]>) -> Void) {
        self.tmdb.genre.request(.list(apiKey: Constants.API.apiKey, language: self.language)) { (moyaResult) in
            switch moyaResult {
            case .success(let response):
                if let arrayGenres = response.mapGenres() {
                    result(.success(object: arrayGenres))
                }else{
                    result(.empty)
                }
            case .failure(let error):
                result(.failure(error: error))
            }
        }
    }

    public func saveGenres(genres: [Genre]) {
        
    }
}
