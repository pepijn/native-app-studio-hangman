//
//  Guess.swift
//  Hangman
//
//  Created by Pepijn Looije on 29/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

class Guess {
    static private let unknownCharacter = Character("-")
    private let guessedLetter: Character
    private let wordList: Set<String>
    private let initialStatus: [Character]

    private var wordClasses: [(word: String, equivalenceClass: String)] {
        return wordList.map { (word) -> (word: String, equivalenceClass: String) in
            let characters = word.characters.enumerate().map({ (index, character) -> Character in
                if character == guessedLetter {
                    return character
                }
                return initialStatus[index]
            })
            return (word, characters.map { String($0) }.joinWithSeparator(""))
        }
    }

    var equivalenceClasses: [String: Set<String>] {
        return wordClasses.reduce([String: Set<String>]()) { (var collection, word) -> [String: Set<String>] in
            if collection[word.equivalenceClass] == nil {
                collection[word.equivalenceClass] = Set()
            }
            collection[word.equivalenceClass]!.insert(word.word)
            return collection
        }
    }

    var favoredEquivalenceClass: String {
        let counts = equivalenceClasses.map { (
            word: $0.0,
            classSize: $0.1.count,
            unknownCharacterCount: $0.0.characters.filter { $0 == Guess.unknownCharacter }.count)
        }
        return counts.sort {
            if $0.classSize != $1.classSize {
                return $0.classSize > $1.classSize
            } else {
                return $0.unknownCharacterCount > $1.unknownCharacterCount
            }
        }.first!.0
    }

    var remainingWordList: Set<String> {
        return equivalenceClasses[favoredEquivalenceClass]!
    }

    var correctGuess: Bool {
        return Array(favoredEquivalenceClass.characters) != initialStatus
    }

    init(letter: String, wordList: Set<String>? = nil, previousGuess: Guess? = nil) {
        self.guessedLetter = Character(letter.lowercaseString)
        if previousGuess == nil {
            self.wordList = wordList!
            self.initialStatus = wordList!.first!.characters.map({ (_) -> Character in
                return Guess.unknownCharacter
            })
        } else {
            self.wordList = previousGuess!.remainingWordList
            self.initialStatus = Array(previousGuess!.favoredEquivalenceClass.characters)
        }
    }
}