//
//  EngineTests.swift
//  Hangman
//
//  Created by Pepijn Looije on 30/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import XCTest

class EngineTests: XCTestCase {
    let wordList = Set(["bear", "boar", "deer", "duck", "hare"])

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCompletion() {
        let engine = EvilEngine.init(wordList: wordList, maxMistakes: 3)
        XCTAssertEqual(engine.description, "----")
        XCTAssertFalse(engine.guessLetter("e"))
        XCTAssertFalse(engine.guessLetter("b"))
        XCTAssertEqual(engine.incorrectlyGuessedLetters, Set(["e", "b"]))
        XCTAssert(engine.guessLetter("d"))
        XCTAssert(engine.guessLetter("u"))
        XCTAssert(engine.guessLetter("c"))
        XCTAssertEqual(engine.description, "duc-")
        XCTAssert(engine.guessLetter("k"))
        XCTAssertEqual(engine.correctlyGuessedLetters, Set(["d", "u", "c", "k"]))
        XCTAssert(engine.finished)
        XCTAssert(engine.won)
    }

    func testFailure() {
        let engine = EvilEngine.init(wordList: wordList, maxMistakes: 2)
        XCTAssertFalse(engine.guessLetter("e"))
        XCTAssertFalse(engine.guessLetter("b"))
        XCTAssert(engine.failed)
        XCTAssert(engine.finished)
        XCTAssertFalse(engine.guessLetter("d"))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
