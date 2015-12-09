//
//  HighscoreList.swift
//  Hangman
//
//  Created by Pepijn Looije on 03/12/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

class HighscoreList {
    static private let userDefaultsKey = "highscores"
    static private let wordKey = "word"
    static private let mistakesKey = "mistakes"
    static let sharedInstance = HighscoreList()

    private var _highscores: [[String: AnyObject]] {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var highscores = userDefaults.objectForKey(HighscoreList.userDefaultsKey)

        if highscores == nil {
            saveHighscores([[String: AnyObject]]())
            highscores = userDefaults.objectForKey(HighscoreList.userDefaultsKey)
        }

        return highscores as! [[String: AnyObject]]
    }

    var highscores: [Highscore] {
        let list = _highscores.enumerate().map { (index, highscore) -> Highscore in
            let word = highscore[HighscoreList.wordKey] as! String
            let mistakes = highscore[HighscoreList.mistakesKey] as! Int
            let mostRecent = index + 1 == _highscores.count
            return Highscore.init(word: word, mistakes: mistakes, mostRecent: mostRecent)
        }

        // TODO: sort by mistakes and mostRecent
        return list.sort { $0.0.mistakes < $0.1.mistakes }
    }

    private init() {
    }

    func submitHighscore(word: String, mistakes: Int) {
        var tempHighscores = _highscores
        var entry = [String: AnyObject]()
        entry[HighscoreList.wordKey] = word
        entry[HighscoreList.mistakesKey] = mistakes
        tempHighscores.append(entry)
        saveHighscores(tempHighscores)
    }

    func reset() {
        saveHighscores(nil)
    }

    func saveHighscores(highscores: [[String: AnyObject]]?) {
        NSUserDefaults.standardUserDefaults().setObject(highscores, forKey: HighscoreList.userDefaultsKey)
    }
}