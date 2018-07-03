//
//  MovieDetailsInteractor.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 05/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation

class MovieDetailsInteractor: MovieDetailsUseCase {
    weak var output: MovieDetailsInteractorOutput?
    let dataManager = DataManager()
    
    func fetchGenres() {
        dataManager.getGenres { [weak self] (result) in
            switch result {
            case .success(let genres):
                self?.output?.genresFetched(genres: genres)
            case .failure( _):
                self?.output?.genresFetchFailed()
            case .empty:
                self?.output?.genresFetchFailed()
            }
        }
    }
}
