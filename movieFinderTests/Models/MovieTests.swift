//
//  GenreTests.swift
//  movieFinderTests
//
//  Created by Narlei A Moreira on 19/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import XCTest
@testable import movieFinder

class MovieTests: XCTestCase {
    
    var movie:Movie!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitFromJson() {
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
    
}
