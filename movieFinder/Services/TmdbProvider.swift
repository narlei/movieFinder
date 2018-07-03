//
//  TmdbProvider.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 18/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Moya

public protocol TmdbProvider: class {
    var movie: MoyaProvider<MovieService> { get }
    var genre: MoyaProvider<GenreService> { get }
}
