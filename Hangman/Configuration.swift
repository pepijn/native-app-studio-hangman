//
//  Configuration.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

class Configuration {
    static let maxMaxIncorrectGuesses = 26
    static private let defaultMaxIncorrectGuesses = 10
    static private let defaultIsEvilMode = true

    static let sharedInstance = Configuration()

    var lengthOfWord = WordList.sharedInstance.wordList.first!.characters.count
    var maxIncorrectGuesses = defaultMaxIncorrectGuesses
    var evilMode = defaultIsEvilMode

    var engine: Engine {
        if evilMode {
            let words = WordList.sharedInstance.nLetterWords(lengthOfWord)
            return EvilEngine.init(words: words, maxMistakes: maxIncorrectGuesses)
        } else {
            return HonestEngine.init(word: WordList.sharedInstance.nLetterWord(lengthOfWord), maxMistakes: maxIncorrectGuesses)
        }
    }
}