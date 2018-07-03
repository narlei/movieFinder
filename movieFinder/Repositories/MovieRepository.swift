//
//  MovieRepository.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 18/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation


public protocol MovieRepository: class {
    func fetchMovies(page: Int, result:@escaping (MFResult<[Movie]>) -> Void)
    func searchMovies(page: Int, query: String,  result:@escaping (MFResult<[Movie]>) -> Void)
    func saveMovies(movies:[Movie], clear:Bool)
}
