//
//  Progress.swift
//  Hangman
//
//  Created by Pepijn Looije on 10/12/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

// The Progress class takes care of the letters that show the state of the game
// to the user in a graphical way.
class Progress {
    let mistakes: Int
    let remaining: Int
    var wonGame: Bool?

    var total: Int {
        return mistakes + remaining
    }

    // This method uses a mathematical formula to determine the amount of extra
    // As that have to be added in hangma<here>n.
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

    init(mistakes: Int, remaining: Int, wonGame: Bool? = nil) {
        self.mistakes = mistakes
        self.remaining = remaining
        self.wonGame = wonGame
    }
}