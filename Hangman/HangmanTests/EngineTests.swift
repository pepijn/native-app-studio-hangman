//
//  Engine.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import XCTest

class EngineTests: XCTestCase {
    let wordList = Set(["bear", "boar", "deer", "duck", "hare"])

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGuessE() {
        let guess = Guess.init(letter: "e", wordList: wordList)
        var expectedClasses = [String: Set<String>]()
        expectedClasses["----"] = Set(["boar", "duck"])
        expectedClasses["-e--"] = Set(["bear"])
        expectedClasses["-ee-"] = Set(["deer"])
        expectedClasses["---e"] = Set(["hare"])
        XCTAssertEqual(guess.equivalenceClasses, expectedClasses)
        XCTAssertEqual(guess.favoredEquivalenceClass, "----")
        XCTAssertEqual(guess.remainingWordList, Set(["boar", "duck"]))
    }

    func testGuessR() {
        let guess = Guess.init(letter: "R", wordList: wordList)
        let expectedClasses = [
            "----": Set(["duck"]),
            "---r": Set(["bear", "boar", "deer"]),
            "--r-": Set(["hare"])
        ]
        XCTAssertEqual(guess.equivalenceClasses, expectedClasses)
        XCTAssertEqual(guess.favoredEquivalenceClass, "---r")
    }

    func testGuessUnknownCharactersSort() {
        let wordList = Set(["hare", "deer", "boar"])
        let guess = Guess.init(letter: "e", wordList: wordList)
        let expectedClasses = [
            "----": Set(["boar"]),
            "-ee-": Set(["deer"]),
            "---e": Set(["hare"])
        ]
        XCTAssertEqual(guess.equivalenceClasses, expectedClasses)
        XCTAssertEqual(guess.favoredEquivalenceClass, "----")
    }

    func testEvilGameplay() {
        var guess = Guess.init(letter: "e", wordList: wordList)
        XCTAssertEqual(guess.favoredEquivalenceClass, "----")
        guess = Guess.init(letter: "b", previousGuess: guess)
        XCTAssertEqual(guess.favoredEquivalenceClass, "----")
        guess = Guess.init(letter: "d", previousGuess: guess)
        XCTAssertEqual(guess.favoredEquivalenceClass, "d---")
        guess = Guess.init(letter: "f", previousGuess: guess)
        XCTAssertFalse(guess.correctGuess)
        guess = Guess.init(letter: "u", previousGuess: guess)
        guess = Guess.init(letter: "c", previousGuess: guess)
        guess = Guess.init(letter: "k", previousGuess: guess)
        XCTAssertEqual(guess.favoredEquivalenceClass, "duck")
        XCTAssert(guess.correctGuess)
    }

    func testHonestEngine() {
        return
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
        return
        let engine = EvilEngine.init()
        XCTAssertFalse(engine.guessLetter("e"))
        //XCTAssert(engine.guessLetter("r"))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
