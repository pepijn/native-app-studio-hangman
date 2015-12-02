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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        entryField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func enteredLetter(sender: UITextField) {
        print(sender.text!)
        sender.text = ""
    }
}