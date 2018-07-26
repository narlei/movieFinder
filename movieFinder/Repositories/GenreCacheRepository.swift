//
//  GenreCacheRepository.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 18/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation

public class GenreCacheRepository: GenreRepository {
    
    static let cacheKey = "genres"
    
    public func fetchGenres(result:@escaping (MFResult<[Genre]>) -> Void) {
        if let genres = self.getCachedGenres() {
            result(.success(object: genres))
        }else{
            result(.empty)
        }
    }
    
    public func saveGenres(genres: [Genre]) {
        let arraySave = NSMutableArray(capacity: genres.count)
        
        for item in genres {
            arraySave.add(NSKeyedArchiver.archivedData(withRootObject: item))
        }
        
        UserDefaults.standard.setValue(arraySave, forKey: GenreCacheRepository.cacheKey)
        UserDefaults.standard.synchronize()
    }
    
    private func getCachedGenres() -> [Genre]? {
        guard let cached = UserDefaults.standard.value(forKey: GenreCacheRepository.cacheKey) else {
            return nil
        }
        let genresAr = cached as! [Data]
        var genres = [Genre]()
        for item in genresAr {
            genres.append(NSKeyedUnarchiver.unarchiveObject(with: item) as! Genre)
        }
        return genres
    }
}
