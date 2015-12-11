//
//  Highscore.swift
//  Hangman
//
//  Created by Pepijn Looije on 03/12/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

// An instance of the Highscore class represents an entry in the highscore list
class Highscore {
    let word: String
    let mistakes: Int
    let mostRecent: Bool

    init(word: String, mistakes: Int, mostRecent: Bool) {
        self.word = word
        self.mistakes = mistakes
        self.mostRecent = mostRecent
    }
}