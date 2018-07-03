//
//  MovieCacheRepositoryTests.swift
//  movieFinderTests
//
//  Created by Narlei A Moreira on 19/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import XCTest
@testable import movieFinder

class MovieCacheRepositoryTests: XCTestCase {
    
    var movie:Movie!
    let movieCacheRepository: MovieCacheRepository = MovieCacheRepository()
    
    override func setUp() {
        super.setUp()
        let path = Bundle.main.path(forResource: "MovieMock", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!))
            if let json  = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String:Any] {
                self.movie = Movie(fromDictionary: json)
            }
        } catch(let error) {
            assertionFailure(error.localizedDescription)
        }
        assert(self.movie != nil, "Error initializing movie")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testSaveMovies() {
        UserDefaults.standard.setValue(nil, forKey: MovieCacheRepository.cacheKey)
        
        self.movieCacheRepository.saveMovies(movies: [self.movie], clear: true)
        
        let cached = UserDefaults.standard.value(forKey: MovieCacheRepository.cacheKey)
        assert(cached != nil, "Error creating Movie Cache")
    }
    
    func testFetchMovies() {
        let arraySave = NSMutableArray(capacity: 1)
        arraySave.add(NSKeyedArchiver.archivedData(withRootObject: self.movie))
        UserDefaults.standard.setValue(arraySave, forKey: MovieCacheRepository.cacheKey)
        
        self.movieCacheRepository.fetchMovies(page: 0) { (result) in
            switch result {
            case .success(let movies):
                let movie = movies.first
                assert(movie != nil, "Fetch movie error (returns empty array)")
                assert(movie!.id == self.movie.id, "Fetch movie error (return wrong cache)")
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            case .empty:
                assertionFailure("Fetch movie error (returns empty)")
            }
        }
    }
    
    func testSearchMovies() {
        self.movie.title = "Jurassic World"
        let arraySave = NSMutableArray(capacity: 1)
        arraySave.add(NSKeyedArchiver.archivedData(withRootObject: self.movie))
        UserDefaults.standard.setValue(arraySave, forKey: MovieCacheRepository.cacheKey)
        
        self.movieCacheRepository.searchMovies(page: 0, query: "Jura") { (result) in
            switch result {
            case .success(let movies):
                let movie = movies.first
                assert(movie != nil, "Search movie error (returns empty array)")
                assert(movie!.id == self.movie.id, "Search movie error (return wrong cache)")
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            case .empty:
                assertionFailure("Search movie error (returns empty)")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
