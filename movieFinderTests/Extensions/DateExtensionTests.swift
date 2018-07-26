//
//  DateExtensionTests.swift
//  movieFinderTests
//
//  Created by Narlei A Moreira on 06/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import XCTest
@testable import movieFinder

class DateExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDateSuccess(){
        let dateStr = "2018-07-04"
        let formattedDate = dateStr.toDateFormat(format: "dd-MM-YYYY")
        assert(formattedDate == "04-07-2018", "Date formatter error")
    }
    
    func testDateFailure(){
        let dateStr = "2018-07"
        let formattedDate = dateStr.toDateFormat(format: "dd-MM-YYYY")
        assert(formattedDate == "", "Date formatter error")
    }
}
