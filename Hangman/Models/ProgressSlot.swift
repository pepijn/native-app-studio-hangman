//
//  ProgressSlot.swift
//  Hangman
//
//  Created by Pepijn Looije on 11/12/15.
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