//
//  constantsTests.swift
//  movieFinderTests
//
//  Created by Narlei A Moreira on 05/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import XCTest

class ConstantsTests: XCTestCase {
    
    let baseUrl = "https://api.themoviedb.org/3/"
    let apiKey = "7e8a76c1bd818cc68473abb1e5fc2a20"
    let language = "pt-BR"
    let imageBaseUrl = "https://image.tmdb.org/t/p/w"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValues() {
        
        assert(Constants.API.baseUrl == baseUrl,           "BaseUrl Invalid")
        assert(Constants.API.apiKey == apiKey,             "Api Key Invalid")
        assert(Constants.API.language == language,         "Language Invalid")
        assert(Constants.API.imageBaseUrl == imageBaseUrl, "Image BaseUrl Invalid")
        
    }
}
