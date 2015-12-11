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
    let next: Bool

    var description: String {
        if filled {
            return String(character).uppercaseString
        }
        if next {
            return "\(String(character))_"
        }
        return String(character)
    }

    init(character: Character, filled: Bool, next: Bool) {
        self.character = character
        self.filled = filled
        self.next = next
    }
}

class Progress {
    let mistakes: Int
    let remaining: Int
    let wonGame: Bool

    var total: Int {
        return mistakes + remaining
    }

    var extraACount: Int {
        let y = Int(floor(Float(total) / 4))
        let z = min(Int(floor(Float(total) / 7)), 1)

        return ((((total % 4) + y) + y - 1) * (y + 1) - y) * (1 - z) + z * (total - 7)
    }

    private var extraAs: [Character] {
        return [Character](count: extraACount, repeatedValue: Character("a"))
    }

    private var base: String {
        return "hangma\(String(extraAs))n"
    }

    private var partSize: Int {
        return base.characters.count / total
    }

    private var splitIndex: Int {
        return partSize * mistakes
    }

    private var nextSplitIndex: Int {
        return partSize * (mistakes + 1)
    }

    var progressSlots: [ProgressSlot] {
        return base.characters.enumerate().map({ (index, character) -> ProgressSlot in
            ProgressSlot(character: character, filled: index < splitIndex, next: index < nextSplitIndex)
        })
    }

    var description: String {
        return progressSlots.map { $0.description }.joinWithSeparator("")
    }

    convenience init(engine: Engine) {
        self.init(
            mistakes: engine.incorrectlyGuessedLetters.count,
            remaining: engine.incorrectGuessesRemaining,
            wonGame: engine.wonGame
        )
    }

    init(mistakes: Int, remaining: Int, wonGame: Bool) {
        self.mistakes = mistakes
        self.remaining = remaining
        self.wonGame = wonGame
    }
}