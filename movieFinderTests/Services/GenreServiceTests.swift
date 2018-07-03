//
//  genreServiceTests.swift
//  movieFinderTests
//
//  Created by Narlei A Moreira on 05/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import XCTest
import Moya
@testable import movieFinder

class GenreServiceTests: XCTestCase {
    
    let provider = MoyaProvider<GenreService>(stubClosure: MoyaProvider.immediatelyStub)
    
    
    func testListMovies(){
        provider.request(.list(apiKey: Constants.API.apiKey, language: "en")) { (result) in
            switch result {
            case .success(let response):
                let genres = response.mapGenres()
                assert(genres != nil, "[GenreService] Genre List ERROR")
                
            case .failure(let error):
                assertionFailure("[GenreService] Genre List ERROR \(error.localizedDescription)")
            }
        }
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
