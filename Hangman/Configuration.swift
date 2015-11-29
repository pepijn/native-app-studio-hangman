//
//  Configuration.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

class Configuration {
    static var defaultMaxIncorrectGuesses = 10
    static var defaultIsEvilMode = true

    static var sharedInstance = Configuration()

    var lengthOfWord: Int
    var maxIncorrectGuesses = defaultMaxIncorrectGuesses
    var evilMode = defaultIsEvilMode

    init() {
        self.lengthOfWord = WordList.sharedInstance.wordList.first!.characters.count
    }
}