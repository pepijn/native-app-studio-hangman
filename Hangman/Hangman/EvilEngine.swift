//
//  EvilEngine.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

class EvilEngine : Engine {
    var word: String {
        return "eviltwin"
    }

    var correctlyGuessedLetters: Set<Character> {
        return guessedLetters.intersect(Set(word.characters))
    }

    var incorrectlyGuessedLetters: Set<Character> {
        return guessedLetters.subtract(correctlyGuessedLetters)
    }

    var status: [Character?] {
        return word.characters.map { (character) -> Character? in
            if guessedLetters.contains(character) {
                return character
            }
            return nil
        }
    }

    var description: String {
        return status.map({ (character) -> String in
            if character != nil {
                return String(character!)
            }
            return Engine.unknownLetter
        }).joinWithSeparator("")
    }

    func guessLetter(string: String) -> Bool {
        return guessLetter(Character.init(string))
    }

    func guessLetter(character: Character) -> Bool {
        if !guessedLetters.contains(character) {
            // Prevent already guessed characters from being stored again
            guesses.append(character)
        }

        return word.containsString(String(character))
    }
}