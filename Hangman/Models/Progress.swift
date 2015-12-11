//
//  Progress.swift
//  Hangman
//
//  Created by Pepijn Looije on 10/12/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

struct ProgressSlot {
    let character: Character
    let filled: Bool

    var description: String {
        if filled {
            return String(character).uppercaseString
        }
        return String(character)
    }

    init(character: Character, filled: Bool) {
        self.character = character
        self.filled = filled
    }
}

class Progress {
    let mistakes: Int
    let remaining: Int

    var total: Int {
        return mistakes + remaining
    }

    var extraACount: Int {
        let y = Int(floor(Float(total) / 4))
        let z = Int(floor(Float(total) / 7))
        return ((((total % 4) + y) + y - 1) * (y + 1) - y) * (1 - z) + z * (total - 7)
    }

    private var extraAs: [Character] {
        return [Character](count: extraACount, repeatedValue: Character("a"))
    }

    private var base: String {
        var string = "hangma"
        string.appendContentsOf(String(extraAs))
        string.appendContentsOf("n")
        return string
    }

    var splitIndex: Int {
        let partSize = base.characters.count / total
        return partSize * mistakes
    }

    var progressSlots: [ProgressSlot] {
        return base.characters.enumerate().map({ (index, character) -> ProgressSlot in
            ProgressSlot(character: character, filled: index < splitIndex)
        })
    }

    var description: String {
        return progressSlots.map { $0.description }.joinWithSeparator("")
    }

    init(mistakes: Int, remaining: Int) {
        self.mistakes = mistakes
        self.remaining = remaining
    }
}