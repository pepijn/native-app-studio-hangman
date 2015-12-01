//
//  HonestEngine.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

class HonestEngine : Engine {
    init(word: String, maxMistakes: Int) {
        super.init(wordList: Set([word]), maxMistakes: maxMistakes)
    }
}