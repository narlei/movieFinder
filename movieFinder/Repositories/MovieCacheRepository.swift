//
//  MovieCacheRepository.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 18/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation

public class MovieCacheRepository: MovieRepository {
    
    static let cacheKey = "movies"
    
    public func fetchMovies(page: Int, result:@escaping (MFResult<[Movie]>) -> Void) {
        if let movies = self.getCachedMovies(), page < 2 {
            result(.success(object: movies))
        }else{
            result(.empty)
        }
    }
    
    public func searchMovies(page: Int, query: String,  result:@escaping (MFResult<[Movie]>) -> Void) {
        if let movies = self.getCachedMovies() {
            let filtered = movies.filter { (movie) -> Bool in
                return movie.title.contains(query)
            }
            result(.success(object: filtered))
        }else{
            result(.empty)
        }
    }
    
    public func saveMovies(movies: [Movie], clear:Bool) {
        var savedMovies = [Movie]()
        if !clear {
            if let cached = getCachedMovies() {
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
        
        UserDefaults.standard.setValue(arraySave, forKey: MovieCacheRepository.cacheKey)
        UserDefaults.standard.synchronize()
    }
    
    private func getCachedMovies() -> [Movie]? {
        guard let cached = UserDefaults.standard.value(forKey: MovieCacheRepository.cacheKey) else {
            return nil
        }
        let moviesAr = cached as! [Data]
        var movies = [Movie]()
        for item in moviesAr {
            movies.append(NSKeyedUnarchiver.unarchiveObject(with: item) as! Movie)
        }
        return movies
    }
}
