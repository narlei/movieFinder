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
    
    let api = TmdbAPI()
    
    static let shared = DataManager()
    private init() {
        
    }
    
    // MARK: Genre
    
    func getGenres(onComplete:@escaping (MFResult<[Genre]>) -> Void) {
        api.genre.request(.list(apiKey: Constants.API.apiKey, language: Constants.API.language)) { (result) in
            switch result {
            case .success(let response):
                if let arrayGenres = response.mapGenres() {
                    self.cacheGenres(genres: arrayGenres)
                    onComplete(.success(object: arrayGenres))
                    return
                }
                if let arrayGenres = self.uncacheGenres(){
                    onComplete(.success(object: arrayGenres))
                }else{
                    onComplete(.emtpy)
                }
            case .failure(let error):
                if let arrayGenres = self.uncacheGenres(){
                    onComplete(.success(object: arrayGenres))
                }else{
                    onComplete(.failure(error: error))
                }
                break
            }
        }
    }
    
    func uncacheGenres() -> [Genre]? {
        guard let cached = UserDefaults.standard.value(forKey: "genres") else {
            return nil
        }
        let genresAr = cached as! [Data]
        var genres = [Genre]()
        for item in genresAr {
            genres.append(NSKeyedUnarchiver.unarchiveObject(with: item) as! Genre)
        }
        return genres
    }
    
    private func cacheGenres(genres:[Genre]) {

        let arraySave = NSMutableArray(capacity: genres.count)
        
        for item in genres {
            arraySave.add(NSKeyedArchiver.archivedData(withRootObject: item))
        }
        
        
        UserDefaults.standard.setValue(arraySave, forKey: "genres")
        UserDefaults.standard.synchronize()
    }
    
    
    
    // MARK: Movies

    func getMovies(page: Int, onComplete:@escaping (MFResult<[Movie]>) -> Void) {
        api.movie.request(.list(apiKey: Constants.API.apiKey, language: Constants.API.language, page: page)) { (result) in
            switch result {
            case .success(let response):
                if let arrayMovies = response.mapMovies() {
                    self.cacheMovies(movies: arrayMovies, clear: page == 1)
                    onComplete(.success(object: arrayMovies))
                    return
                }
                if let arrayMovies = self.uncacheMovies(), page == 1 {
                    onComplete(.success(object: arrayMovies))
                }else{
                    onComplete(.emtpy)
                }
            case .failure(let error):
                if let arrayMovies = self.uncacheMovies(), page == 1 {
                    onComplete(.success(object: arrayMovies))
                }else{
                    onComplete(.failure(error: error))
                }
                break
            }
        }
    }
    
    private func uncacheMovies() -> [Movie]? {
        guard let cached = UserDefaults.standard.value(forKey: "movies") else {
            return nil
        }
        let moviesAr = cached as! [Data]
        var movies = [Movie]()
        for item in moviesAr {
            movies.append(NSKeyedUnarchiver.unarchiveObject(with: item) as! Movie)
        }
        return movies
    }
    
    private func cacheMovies(movies:[Movie], clear:Bool) {
        var savedMovies = [Movie]()
        if !clear {
            if let cached = uncacheMovies() {
                savedMovies = cached
            }
        }
        let arraySave = NSMutableArray(capacity: movies.count + savedMovies.count)
        for item in savedMovies {
            arraySave.add(NSKeyedArchiver.archivedData(withRootObject: item))
        }
        for item in movies {
            arraySave.add(NSKeyedArchiver.archivedData(withRootObject: item))
        }
        
        
        UserDefaults.standard.setValue(arraySave, forKey: "movies")
        UserDefaults.standard.synchronize()
    }
    
    
}
