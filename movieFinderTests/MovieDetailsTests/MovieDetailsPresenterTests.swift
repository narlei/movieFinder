//
//  MovieDetailsPresenterTests.swift
//  movieFinderTests
//
//  Created by Narlei A Moreira on 06/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import XCTest

class MovieDetailsPresenterTests: XCTestCase {
    
    let presenter = MovieDetailsPresenter()
    let view = MovieDetailsViewFake()
    
    var arrayGenres:[Genre] = [Genre]()
    var movie:Movie!
    
    override func setUp() {
        super.setUp()
        let movie = Movie(fromDictionary: ["id": 1, "title": "Jurrasic World", "genre_ids": [12]])
        
        presenter.view = view
        view.presenter = presenter
        presenter.movie = movie
        
        arrayGenres.append(Genre(fromDictionary: ["id":1, "name": "Ação"]))
        arrayGenres.append(Genre(fromDictionary: ["id":12, "name": "Aventura"]))
    }
    
    func testGenresFetched() {
        presenter.genresFetched(genres: arrayGenres)
        assert(view.arrayGenresShowed != nil, "Genres fetch conversion error")
        assert(view.arrayGenresShowed!.count == 1, "Genres not filtered")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
