//
//  MovieListViewController.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 04/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

class MovieListViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var tableViewMovies: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func actionButtonSearch(_ sender: Any) {
        self.presenter.didOpenSearchMovie()
    }
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.didCloseSearchMovie()
    }
    
    fileprivate func setupView() {
        self.tableViewMovies.delegate = self
        self.tableViewMovies.dataSource = self
        self.tableViewMovies.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "cellMovie")
       
        self.tableViewMovies.infiniteScrollIndicatorStyle = UIActivityIndicatorViewStyle.gray
        self.tableViewMovies.addInfiniteScroll { (tableView) -> Void in
            DispatchQueue.main.async {
                self.presenter.didLoadNexPage()
            }
        }
        
        self.tableViewMovies.tableHeaderView = self.searchBar
        self.searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: View

extension MovieListViewController: MovieListView {
    func showNoContentScreen() {
        self.tableViewMovies.finishInfiniteScroll()
    }
    
    func showMoviesData(_ movies: [Movie]) {
        self.arrayMovies = movies
        self.tableViewMovies.finishInfiniteScroll()
    }
    
    func showSearchBar() {
        let offset = CGPoint.init(x: 0, y: 0)
        self.tableViewMovies.setContentOffset(offset, animated: false)
        self.searchBar.becomeFirstResponder()
    }
    
    func hideSearchBar() {
        let offset = CGPoint.init(x: 0, y: self.searchBar.bounds.height)
        self.tableViewMovies.setContentOffset(offset, animated: false)
        self.searchBar.resignFirstResponder()
        self.searchBar.text = ""
    }
}

// MARK: TableView

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

// MARK: Search

extension MovieListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presenter.didCloseSearchMovie()
        self.presenter.reload()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.presenter.didSearchMovie(query: searchBar.text!)
    }
}

