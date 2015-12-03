//
//  EvilEngine.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

class EvilEngine : Engine {
    init(words: Set<String>, maxMistakes: Int) {
        super.init(wordList: words, maxMistakes: maxMistakes)
    }
}