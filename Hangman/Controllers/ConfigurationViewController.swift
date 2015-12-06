//
//  ConfigurationViewController.swift
//  Hangman
//
//  Created by Pepijn Looije on 03/12/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {
    @IBOutlet weak var wordLengthStepper: UIStepper!
    @IBOutlet weak var wordLength: UILabel!
    @IBOutlet weak var incorrectGuessesStepper: UIStepper!
    @IBOutlet weak var incorrectGuesses: UILabel!
    @IBOutlet weak var styleSwitch: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        wordLengthStepper.minimumValue = Double(WordList.shortList.minimumWordLength)
        wordLengthStepper.maximumValue = Double(WordList.shortList.maximumWordLength)

        incorrectGuessesStepper.minimumValue = 1.0
        incorrectGuessesStepper.maximumValue = Double(Configuration.maxMaxIncorrectGuesses)

        var selectedIndex: Int
        if Configuration.sharedInstance.evilMode {
            selectedIndex = 0
        } else {
            selectedIndex = 1
        }
        styleSwitch.selectedSegmentIndex = selectedIndex

        setLabels()
    }

    @IBAction func wordLengthChanged(sender: UIStepper) {
        Configuration.sharedInstance.lengthOfWord = Int(sender.value)
        setLabels()
    }

    @IBAction func maxIncorrectGuessesChanged(sender: UIStepper) {
        Configuration.sharedInstance.maxIncorrectGuesses = Int(sender.value)
        setLabels()
    }

    func setLabels() {
        wordLengthStepper.value = Double(Configuration.sharedInstance.lengthOfWord)
        wordLength.text = String(Configuration.sharedInstance.lengthOfWord)

        incorrectGuessesStepper.value = Double(Configuration.sharedInstance.maxIncorrectGuesses)
        incorrectGuesses.text = String(Configuration.sharedInstance.maxIncorrectGuesses)
    }

    @IBAction func styleChanged(sender: UISegmentedControl) {
        let evil = sender.selectedSegmentIndex == 0
        Configuration.sharedInstance.evilMode = evil
        setLabels()
    }
}