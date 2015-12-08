//
//  ConfigurationTests.swift
//  Hangman
//
//  Created by Pepijn Looije on 02/12/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import XCTest

class ConfigurationTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDefaults() {
        let configuration = Configuration()
        XCTAssertEqual(configuration.lengthOfWord, 8)
        XCTAssertEqual(configuration.maxIncorrectGuesses, 10)
        XCTAssertEqual(configuration.evilMode, true)
        XCTAssertEqual(String(configuration.engine.dynamicType), "EvilEngine")
        configuration.evilMode = false
        XCTAssertEqual(String(configuration.engine.dynamicType), "HonestEngine")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
}