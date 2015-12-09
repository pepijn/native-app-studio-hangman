//
//  Configuration.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import Foundation

class Configuration {
    static private let configurationKey = "configuration"
    static private let lengthOfWordKey = "lengthOfWord"
    static private let maxIncorrectGuessesKey = "maxIncorrectGuesses"
    static private let evilModeKey = "evilMode"

    static let maxMaxIncorrectGuesses = 26
    static private let defaultMaxIncorrectGuesses = 10
    static private let defaultIsEvilMode = true

    static let sharedInstance = Configuration()

    private var store: [String: AnyObject] {
        get {
            if let store = NSUserDefaults.standardUserDefaults().objectForKey(Configuration.configurationKey) {
                return store as! [String: AnyObject]
            }
            return [String: AnyObject]()
        }

        set {
            storeConfig(newValue)
        }
    }

    var lengthOfWord: Int {
        get {
            let value = store[Configuration.lengthOfWordKey] as? Int
            let defaultValue = WordList.sharedInstance.wordList.first!.characters.count

            return getConfig(value, defaultValue: defaultValue) as! Int
        }

        set {
            setConfig(Configuration.lengthOfWordKey, value: newValue)
        }
    }

    var maxIncorrectGuesses: Int {
        get {
            let value = store[Configuration.maxIncorrectGuessesKey] as? Int
            return getConfig(value, defaultValue: Configuration.defaultMaxIncorrectGuesses) as! Int
        }

        set {
            setConfig(Configuration.maxIncorrectGuessesKey, value: newValue)
        }
    }

    var evilMode: Bool {
        get {
            let value = store[Configuration.evilModeKey] as? Bool

            return getConfig(value, defaultValue: Configuration.defaultIsEvilMode) as! Bool
        }

        set {
            setConfig(Configuration.evilModeKey, value: newValue)
        }
    }

    var engine: Engine {
        if evilMode {
            let words = WordList.sharedInstance.nLetterWords(lengthOfWord)
            return EvilEngine.init(words: words, maxMistakes: maxIncorrectGuesses)
        } else {
            let word = WordList.sharedInstance.nLetterWord(lengthOfWord)
            return HonestEngine.init(word: word, maxMistakes: maxIncorrectGuesses)
        }
    }

    private func getConfig(key: AnyObject?, defaultValue: AnyObject) -> AnyObject {
        if let value = key {
            return value
        }
        return defaultValue
    }

    private func setConfig(key: String, value: AnyObject) {
        var config = store
        config[key] = value
        self.store = config
    }

    private func storeConfig(value: AnyObject?) {
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: Configuration.configurationKey)
    }

    func reset() {
        storeConfig(nil)
    }
}