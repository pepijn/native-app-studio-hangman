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
        let guess = Guess.init(letter: "r", wordList: wordList)
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
        XCTAssertTrue(guess.correctGuess)

        guess = Guess.init(letter: "c", previousGuess: guess)
        guess = Guess.init(letter: "k", previousGuess: guess)
        XCTAssertEqual(guess.favoredEquivalenceClass, "duck")
    }

    func testLargeWordList() {
        return
        let wordList = WordList.sharedInstance.nLetterWords(5)
        let guess = Guess.init(letter: "e", wordList: wordList)

        self.measureBlock {
            // Old method 3 characters:      0.48 sec
            // Old method 5 characters:     16.0 sec
            // NSMutableDictionary:          0.16 sec
            // + Swift dictionary:           0.21 sec
            // + UnicodeScalar => Character: 0.23 sec
            XCTAssertEqual(guess.favoredEquivalenceClass, "-----")
            guess.remainingWordList
        }
    }
}