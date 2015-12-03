//
//  ViewController.swift
//  Hangman
//
//  Created by Pepijn Looije on 28/11/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var entryField: UITextField!
    @IBOutlet weak var remainingGuesses: UILabel!
    @IBOutlet weak var winnerMessage: UILabel!
    @IBOutlet weak var loserMessage: UILabel!

    var engine: Engine? {
        didSet {
            updateStatus()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

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
        status.text = engine!.description
        remainingGuesses.text = String(engine!.incorrectGuessesRemaining)

        if !engine!.finishedGame {
            return
        }
        
        if engine!.wonGame {
            winnerMessage.hidden = false
        } else {
            loserMessage.hidden = false
        }
    }

    @IBAction func restartGame(sender: AnyObject?) {
        loserMessage.hidden = true
        winnerMessage.hidden = true

        self.engine = Configuration.sharedInstance.engine
        entryField.becomeFirstResponder()
    }
}