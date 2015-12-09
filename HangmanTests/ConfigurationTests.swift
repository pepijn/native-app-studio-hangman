//
//  ConfigurationTests.swift
//  Hangman
//
//  Created by Pepijn Looije on 02/12/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import XCTest

class ConfigurationTests: XCTestCase {
    let configuration = Configuration()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        configuration.reset()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDefaults() {
        XCTAssertEqual(configuration.lengthOfWord, 8)
        XCTAssertEqual(configuration.maxIncorrectGuesses, 10)
        XCTAssertEqual(configuration.evilMode, true)
        XCTAssertEqual(String(configuration.engine.dynamicType), "EvilEngine")
        configuration.evilMode = false
        XCTAssertEqual(String(configuration.engine.dynamicType), "HonestEngine")

        configuration.lengthOfWord = 10
        XCTAssertEqual(configuration.lengthOfWord, 10)

        configuration.maxIncorrectGuesses = 3
        XCTAssertEqual(configuration.maxIncorrectGuesses, 3)

        configuration.evilMode = false
        XCTAssertEqual(configuration.evilMode, false)
    }
}