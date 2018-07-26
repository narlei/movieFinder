//
//  GenreCacheRepositoryTests.swift
//  movieFinderTests
//
//  Created by Narlei A Moreira on 19/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import XCTest
@testable import movieFinder

class GenreCacheRepositoryTests: XCTestCase {
    
    var genre:Genre!
    let genreCacheRepository: GenreCacheRepository = GenreCacheRepository()
    
    override func setUp() {
        super.setUp()
        let path = Bundle.main.path(forResource: "GenreMock", ofType: "json")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!))
            if let json  = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String:Any] {
                self.genre = Genre(fromDictionary: json)
            }
        } catch(let error) {
            assertionFailure(error.localizedDescription)
        }
        assert(self.genre != nil, "Error initializing genre")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testSaveGenres() {
        UserDefaults.standard.setValue(nil, forKey: GenreCacheRepository.cacheKey)
        
        self.genreCacheRepository.saveGenres(genres: [self.genre])
        
        let cached = UserDefaults.standard.value(forKey: GenreCacheRepository.cacheKey)
        assert(cached != nil, "Error creating Genre Cache")
    }
    
    func testFetchGenres() {
        let arraySave = NSMutableArray(capacity: 1)
        arraySave.add(NSKeyedArchiver.archivedData(withRootObject: self.genre))
        UserDefaults.standard.setValue(arraySave, forKey: GenreCacheRepository.cacheKey)
        
        self.genreCacheRepository.fetchGenres() { (result) in
            switch result {
            case .success(let genres):
                let genre = genres.first
                assert(genre != nil, "Fetch genre error (returns empty array)")
                assert(genre!.id == self.genre.id, "Fetch genre error (return wrong cache)")
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            case .empty:
                assertionFailure("Fetch genre error (returns empty)")
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
