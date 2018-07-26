//
//  GenreRepository.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 18/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation

public protocol GenreRepository: class {
    func fetchGenres(result:@escaping (MFResult<[Genre]>) -> Void)
    func saveGenres(genres: [Genre])
}
