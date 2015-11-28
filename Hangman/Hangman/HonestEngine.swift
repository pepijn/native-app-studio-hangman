//
//  HonestEngine.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

class HonestEngine : EvilEngine {
    private var staticWord: String
    override var word: String {
        return staticWord
    }

    init(word: String) {
        self.staticWord = word
    }

    func getWord() -> String {
        return staticWord
    }
}