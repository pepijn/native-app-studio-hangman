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
        let engine = EvilEngine.init(words: wordList, maxMistakes: 3)
        XCTAssertEqual(engine.description, "----")
        XCTAssertFalse(engine.guessLetter("e"))
        XCTAssertFalse(engine.guessLetter("b"))
        XCTAssertEqual(engine.incorrectlyGuessedLetters, Set(["e", "b"]))
        XCTAssertFalse(engine.finishedGame)
        XCTAssertFalse(engine.lostGame)
        XCTAssert(engine.guessLetter("d"))
        XCTAssert(engine.guessLetter("U"))
        XCTAssert(engine.guessLetter("c"))
        XCTAssertFalse(engine.lostGame)
        XCTAssertEqual(engine.description, "duc-")
        XCTAssertFalse(engine.wonGame)
        XCTAssert(engine.guessLetter("k"))
        XCTAssertEqual(engine.correctlyGuessedLetters, Set(["d", "u", "c", "k"]))
        XCTAssert(engine.finishedGame)
        XCTAssert(engine.wonGame)
        XCTAssertFalse(engine.lostGame)
    }

    func testFailure() {
        let engine = HonestEngine.init(word: "duck", maxMistakes: 2)
        XCTAssertEqual(engine.incorrectGuessesRemaining, 2)
        XCTAssertFalse(engine.guessLetter("e"))
        XCTAssertFalse(engine.guessLetter("!"))
        XCTAssertEqual(engine.incorrectGuessesRemaining, 1)
        XCTAssertFalse(engine.finishedGame)
        XCTAssertFalse(engine.lostGame)
        XCTAssertFalse(engine.guessLetter("b"))
        XCTAssert(engine.lostGame)
        XCTAssert(engine.finishedGame)
        XCTAssertEqual(engine.word, "duck")
        XCTAssertEqual(engine.incorrectGuessesRemaining, 0)
        XCTAssertFalse(engine.wonGame)
        XCTAssertFalse(engine.guessLetter("d"))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
}