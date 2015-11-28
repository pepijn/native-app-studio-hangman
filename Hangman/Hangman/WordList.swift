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
    var wordList: [String]

    init() {
        let path = NSBundle.mainBundle().pathForResource("small", ofType: "plist")!
        let words = NSArray(contentsOfFile: path) as! [String]
        self.wordList = words.map({ (word) -> String in
            return word.lowercaseString
        })
        print(wordList)
    }
}