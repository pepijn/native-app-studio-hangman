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

    // NSMutableDictionary has better dictionary performance than Swift's
    // See GuessTests testLargeWordList() for details
    private var _equivalenceClasses: NSMutableDictionary {
        let type = [String: Set<String>]()
        let collection = NSMutableDictionary(dictionary: type)

        for (word, equivalenceClass) in wordClasses {
            if collection.objectForKey(equivalenceClass) == nil {
                collection.setObject(NSMutableSet(), forKey: equivalenceClass)
            }
            let set = collection.objectForKey(equivalenceClass) as! NSMutableSet
            set.addObject(word)
            collection.setObject(set, forKey: equivalenceClass)
        }
        return collection
    }

    lazy var equivalenceClasses: [String: Set<String>] = {
        var collection = [String: Set<String>]()

        for (key, value) in self._equivalenceClasses {
            collection[key as! String] = value as? Set<String>
        }

        return collection
    }()

    lazy var favoredEquivalenceClass: String = {
        let counts = self.equivalenceClasses.map { (
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
    }()

    var remainingWordList: Set<String> {
        return equivalenceClasses[favoredEquivalenceClass]!
    }

    var correctGuess: Bool {
        return Array(favoredEquivalenceClass.characters) != initialStatus
    }

    convenience init(letter: String, previousGuess: Guess) {
        self.init(
            letter: letter,
            wordList: previousGuess.remainingWordList,
            status: previousGuess.favoredEquivalenceClass
        )
    }

    init(letter: String? = nil, var character: Character? = nil, wordList: Set<String>, status: String? = nil) {
        if letter != nil {
            character = Character(letter!)
        }

        self.guessedLetter = character!
        self.wordList = wordList

        if status == nil {
            self.initialStatus = [Character](count: wordList.first!.characters.count, repeatedValue: Guess.unknownCharacter)
        } else {
            self.initialStatus = Array(status!.characters)
        }
    }
}