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
    var arrayMovies = [Movie]()
    
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        self.tableViewMovies.delegate = self
        self.tableViewMovies.dataSource = self
        self.tableViewMovies.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "cellMovie")
        self.loadData()
    }
    
    func loadData(){
        DataManager.shared.getMovies(page: 1) { (result) in
            switch result {
            case .success(let movies):
                self.arrayMovies = movies
                self.tableViewMovies.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            case .emtpy:
                print("vazio")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewMovies.deselectRow(at: indexPath, animated: true)
        
        let viewController = UIStoryboard(name: "MovieDetails", bundle: nil).instantiateInitialViewController() as! MovieDetailsViewController
        let movie = self.arrayMovies[indexPath.row]
        viewController.movie = movie
        self.present(viewController, animated: true, completion: nil)
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
