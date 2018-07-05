//
//  MovieListViewController.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 04/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var tableViewMovies: UITableView!
    
    // MARK: Properties
    
    var presenter:MovieListPresentation!
    var arrayMovies:[Movie] = [] {
        didSet {
            self.tableViewMovies.reloadData()
        }
    }
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
    }
    
    fileprivate func setupView() {
        self.tableViewMovies.delegate = self
        self.tableViewMovies.dataSource = self
        self.tableViewMovies.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "cellMovie")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MovieListViewController: MovieListView {
    func showNoContentScreen() {
    
    }
    
    func showMoviesData(_ movies: [Movie]) {
        self.arrayMovies = movies
    }
    
    func showSearchBar() {
    
    }
    
    func hideSearchBar() {
    
    }
    
    
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewMovies.deselectRow(at: indexPath, animated: true)
        
        let movie = self.arrayMovies[indexPath.row]
        self.presenter.didSelectMovie(movie: movie)
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMovies.dequeueReusableCell(withIdentifier: "cellMovie") as! MovieListCell
        let movie = self.arrayMovies[indexPath.row]
        cell.initialize(movie: movie)
        return cell
    }
}
