//
//  Engine.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import XCTest

class EngineTests: XCTestCase {

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

    func testHonestEngine() {
        let engine = HonestEngine.init(word: "test")
        XCTAssertEqual(engine.availableLetters.count, 26)
        XCTAssert(engine.guessLetter("e"))
        XCTAssertEqual(engine.description, "_e__")
        XCTAssertFalse(engine.guessLetter("a"))
        XCTAssert(engine.incorrectlyGuessedLetters.contains(Character.init("a")))
        XCTAssertFalse(engine.incorrectlyGuessedLetters.contains(Character.init("e")))
        XCTAssert(engine.guessLetter("t"))
        XCTAssertEqual(engine.description, "te_t")
        XCTAssert(engine.correctlyGuessedLetters.contains(Character.init("e")))
        XCTAssert(engine.correctlyGuessedLetters.contains(Character.init("t")))
        XCTAssertFalse(engine.correctlyGuessedLetters.contains(Character.init("a")))
        XCTAssert(engine.guessLetter("t"))
        XCTAssertEqual(engine.guesses.count, 3)
        XCTAssertEqual(engine.availableLetters.count, 26 - engine.guesses.count)
    }

    func testEvilEngine() {
        let engine = EvilEngine.init()
        XCTAssertFalse(engine.guessLetter("b"))
        XCTAssertFalse(engine.guessLetter("d"))
        XCTAssert(engine.guessLetter("h"))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
