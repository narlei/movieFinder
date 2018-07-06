//
//  MovieListRouter.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 05/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import Foundation
import UIKit

class MovieListRouter: MovieListWireframe {
    var viewController: UIViewController?
    
    func presentDetails(forMovie movie: Movie) {
        let viewControllerDetails = MovieDetailsRouter.assembleModule(movie: movie)
        viewController?.present(viewControllerDetails, animated: true, completion: nil)
    }
    
    static func assembleModule() -> UIViewController {
        let navigation = UIStoryboard(name: "MovieList", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let viewC = navigation.viewControllers.first as! MovieListViewController
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter()
        let router = MovieListRouter()
        
        viewC.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewC
        
        interactor.output = presenter
        
        router.viewController = viewC
        
        return navigation
        
    }
    
    
}
