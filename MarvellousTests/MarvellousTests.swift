//
//  MarvellousTests.swift
//  MarvellousTests
//
//  Created by Giuseppe Bottiglieri on 20/01/18.
//  Copyright © 2018 gbtt. All rights reserved.
//

import XCTest
@testable import Marvellous

class MarvellousTests: XCTestCase {
    
    func testThumnailURL() {
        let t = Thumbnail(path: "path", extensionPath: "jpg")
        XCTAssertEqual(String(describing: t.url!), "path.jpg")
        
        let x = Thumbnail(path: nil, extensionPath: "jpg")
        XCTAssertEqual(x.url, nil)
        
        let y = Thumbnail(path: "path", extensionPath: nil)
        XCTAssertEqual(y.extensionPath, nil)
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
