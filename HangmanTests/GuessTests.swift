//
//  GuessTests.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import XCTest

class GuessTests: XCTestCase {
    let wordList = Set(["bear", "boar", "deer", "duck", "hare"])

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
        XCTAssert(guess.correctGuess)

        guess = Guess.init(letter: "c", previousGuess: guess)
        guess = Guess.init(letter: "k", previousGuess: guess)
        XCTAssertEqual(guess.favoredEquivalenceClass, "duck")
    }
}