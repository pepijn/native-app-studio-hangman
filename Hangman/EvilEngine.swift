//
//  EvilEngine.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

class EvilEngine : Engine {
    var availableWords: [String] {
        return WordList.sharedInstance.wordList.filter { (word) -> Bool in
            for (index, character) in word.characters.enumerate() {
                if status[index] != nil && status[index] != character {
                    return false
                }
            }
            return true
        }
    }

    var word: String {
        let wordList = guessedLetters.reduce(WordList.sharedInstance.wordList) { (wordList, character) -> Set<String> in
            print(character)
            print(wordList)

            let indexSets = wordList.map({ (word) -> (String, Set<Int>) in
                let characters = word.characters.enumerate().map { ($0.element, $0.index) }
                let filtered = characters.filter { $0.0 == character }
                return (word, Set(filtered.map { $0.1 }))
            })
            print(indexSets)
            let equivalenceClasses = Set(indexSets.map { $0.1 })
            print(equivalenceClasses)
            return wordList
        }
        print(wordList)
        print("\n")
        return wordList.first!
        //return sortedWords.last!.0
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