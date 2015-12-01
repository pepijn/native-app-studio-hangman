//
//  Engine.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

class Engine {
    static private let alphabet = "abcdefghijklmnopqrstuvwxyz"
    static private var allLetters: Set<Character> {
        return Set(alphabet.characters)
    }

    private var wordList: Set<String>
    var status: [Character?]
    let maxMistakes: Int

    // Use an array to keep chronological history of guesses
    internal(set) var guesses = [Character]()

    // Use a set for easier comparisons
    internal var guessedLetters: Set<Character> {
        return Set(guesses)
    }

    var availableLetters: Set<Character> {
        return EvilEngine.allLetters.subtract(guessedLetters)
    }

    var correctlyGuessedLetters: Set<Character> {
        return Set(Array(status).filter { $0 != nil }.map { $0! })
    }

    var incorrectlyGuessedLetters: Set<Character> {
        return guessedLetters.subtract(correctlyGuessedLetters)
    }

    var description: String {
        return status.map({ (character) -> String in
            if character != nil {
                return String(character!)
            }
            return "-"
        }).joinWithSeparator("")
    }

    var lostGame: Bool {
        if incorrectlyGuessedLetters.count >= maxMistakes {
            return true
        }
        return false
    }

    var wonGame: Bool {
        return status.filter { $0 == nil }.count == 0
    }

    var finishedGame: Bool {
        if lostGame || wonGame {
            return true
        }
        return false
    }

    internal init(wordList: Set<String>, maxMistakes: Int) {
        self.wordList = wordList
        self.maxMistakes = maxMistakes
        self.status = [Character?](count: wordList.first!.characters.count, repeatedValue: nil)
    }

    func guessLetter(letter: String) -> Bool {
        if finishedGame {
            return false
        }

        if !guessedLetters.contains(Character(letter)) {
            // Prevent already guessed characters from being stored again
            guesses.append(Character(letter))
        }

        let guess = Guess.init(letter: letter, wordList: wordList, status: description)
        self.wordList = guess.remainingWordList
        self.status = guess.favoredEquivalenceClass.characters.map({ (char) -> Character? in
            if char == "-" {
                return nil
            }
            return char
        })
        return guess.correctGuess
    }
}