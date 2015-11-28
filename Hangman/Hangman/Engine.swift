//
//  Engine.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

class Engine {
    static private var alphabet = "abcdefghijklmnopqrstuvwxyz"
    static private var allLetters: Set<Character> {
        return Set(alphabet.characters)
    }
    static internal var unknownLetter = "_"

    // Use an array to keep chronological history of guesses
    internal(set) var guesses = [Character]()

    // Use a set for easier comparisons
    internal var guessedLetters: Set<Character> {
        return Set(guesses)
    }

    internal var configuration: Configuration

    var availableLetters: Set<Character> {
        return Engine.allLetters.subtract(guessedLetters)
    }

    init() {
        self.configuration = Configuration.sharedInstance
    }
}