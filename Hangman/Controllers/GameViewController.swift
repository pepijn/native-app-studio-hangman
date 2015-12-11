//
//  GameViewController.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var entryField: UITextField!
    @IBOutlet weak var remainingGuesses: UILabel!
    @IBOutlet weak var winnerMessage: UILabel!
    @IBOutlet weak var loserMessage: UILabel!
    @IBOutlet weak var highscoresTableView: UITableView!
    @IBOutlet weak var progressCollectionView: UICollectionView!

    let highscoresViewController = HighscoresViewController()
    var progressViewController = ProgressViewController()

    var engine: Engine? {
        didSet {
            updateStatus()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        highscoresTableView.delegate = highscoresViewController
        highscoresTableView.dataSource = highscoresViewController

        progressCollectionView.delegate = progressViewController
        progressCollectionView.dataSource = progressViewController

        restartGame(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func enteredLetter(sender: UITextField) {
        let letter = sender.text!
        engine!.guessLetter(letter)
        sender.text = ""
        updateStatus()

        if !engine!.finishedGame {
            return
        }

        sender.resignFirstResponder()
    }

    func updateStatus() {
        status.text = engine!.word

        progressViewController.progress = Progress(mistakes: engine!.incorrectlyGuessedLetters.count, remaining: engine!.incorrectGuessesRemaining)
        progressCollectionView.reloadData()

        if !engine!.finishedGame {
            return
        }
        
        gameFinished()
    }

    func gameFinished() {
        if engine!.lostGame {
            loserMessage.hidden = false
            return
        }

        winnerMessage.hidden = false

        let word = engine!.description
        let mistakes = engine!.incorrectlyGuessedLetters.count

        HighscoreList.sharedInstance.submitHighscore(word, mistakes: mistakes)
        highscoresTableView.reloadData()
    }

    @IBAction func restartGame(sender: AnyObject?) {
        loserMessage.hidden = true
        winnerMessage.hidden = true

        self.engine = Configuration.sharedInstance.engine
        entryField.becomeFirstResponder()
    }
}