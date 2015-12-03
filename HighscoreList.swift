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
    static let sharedInstance = HighscoreList()

    var highscores: [[String: AnyObject]] {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var highscores = userDefaults.objectForKey(HighscoreList.userDefaultsKey)

        if highscores == nil {
            userDefaults.setObject([[String: AnyObject]](), forKey: HighscoreList.userDefaultsKey)
            highscores = userDefaults.objectForKey(HighscoreList.userDefaultsKey)
        }

        return highscores as! [[String: AnyObject]]
    }

    func submitHighscore(word: String, mistakes: Int) {
        var tempHighscores = highscores
        var entry = [String: AnyObject]()
        entry["word"] = word
        entry["mistakes"] = mistakes
        tempHighscores.append(entry)
        saveHighscores(tempHighscores)
    }

    func reset() {
        var tempHighscores = highscores
        tempHighscores.removeAll()
        saveHighscores(tempHighscores)
    }

    func saveHighscores(highscores: [[String: AnyObject]]) {
        NSUserDefaults.standardUserDefaults().setObject(highscores, forKey: HighscoreList.userDefaultsKey)
    }
}