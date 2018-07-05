//
//  MovieListContract.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 05/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import UIKit

protocol MovieListView: class {
    var presenter: MovieListPresentation! { get set }
    
    func showNoContentScreen()
    func showMoviesData(_ movies: [Movie])
    func showSearchBar()
    func hideSearchBar()
}

protocol MovieListPresentation: class {
    var view: MovieListView? { get set }
    var interactor: MovieListUseCase! { get set }
    var router: MovieListWireframe! { get set }
    
    func viewDidLoad()
    func reload()
    func didOpenSearchMovie()
    func didCloseSearchMovie()
    func didSearchMovie(query: String)
    func didSelectMovie(movie: Movie)
}

protocol MovieListUseCase: class {
    var output: MovieListInteractorOutput! { get set }
    
    func fetchMovies(page: Int)
}

protocol MovieListInteractorOutput: class {
    func moviesFetched(movies: [Movie])
    func moviesFetchFailed()
}

protocol MovieListWireframe: class {
    var viewController: UIViewController? { get set }
    
    func presentDetails(forMovie movie: Movie)
    
    static func assembleModule() -> UIViewController
}

