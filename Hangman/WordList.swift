//
//  WordList.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

class WordList {
    static var sharedInstance = WordList()
    var wordList: Set<String>

    init() {
        let path = NSBundle.mainBundle().pathForResource("small", ofType: "plist")!
        let words = NSArray(contentsOfFile: path) as! [String]
        self.wordList = Set(words.map({ (word) -> String in
            return word.lowercaseString
        }))
    }

    func nLetterWords(letters: Int) -> Set<String> {
        return Set(wordList.filter({ (word) -> Bool in
            return word.characters.count == letters
        }))
    }

    func nLetterWord(letters: Int) -> String {
        let wordList = nLetterWords(letters)
        let randomIndex = Int(rand()) % wordList.count
        return Array(wordList)[randomIndex]
    }
}