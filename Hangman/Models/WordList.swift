//
//  WordList.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

// The WordList singleton supplies word(s) to the engine.
class WordList {
    static let sharedInstance = WordList(file: "words")

    let wordList: Set<String>

    let minimumWordLength: Int

    let maximumWordLength: Int
    let cache = NSCache()

    private init(file: String) {
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "plist")!
        let words = NSArray(contentsOfFile: path) as! [String]
        self.wordList = Set(words.map({ (word) -> String in
            return word.lowercaseString
        }))

        let wordLengths = wordList.map { Int($0.characters.count) }
        self.minimumWordLength = wordLengths.minElement()!
        self.maximumWordLength = wordLengths.maxElement()!
    }

    func nLetterWords(letters: Int) -> Set<String> {
        let key = letters
        var data = cache.objectForKey(key)
        if data == nil {
            data = Set(wordList.filter({ (word) -> Bool in
                return word.characters.count == letters
            }))
            cache.setObject(data!, forKey: key)
        }
        return data as! Set<String>
    }

    func nLetterWord(letters: Int) -> String {
        let wordList = nLetterWords(letters)
        let randomIndex = Int(rand()) % wordList.count
        return Array(wordList)[randomIndex]
    }
}