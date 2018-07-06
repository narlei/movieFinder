//
//  UIImageExtensionTests.swift
//  movieFinderTests
//
//  Created by Narlei A Moreira on 06/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import XCTest

class UIImageExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testResize() {

        let image = UIImage(named: "imgSearch", in: Bundle(for: type(of: self)), compatibleWith: nil)
        let imageResized = image?.resizeImage(newWidth: 10)
        
        assert(imageResized != nil, "Image resize error durring resize")
        assert(imageResized!.size.width == 10, "Image resize width wrong")
        
    }
}
