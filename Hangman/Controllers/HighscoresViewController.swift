//
//  HighscoresViewController.swift
//  Hangman
//
//  Created by Pepijn Looije on 03/12/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import UIKit

class HighscoresViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let highscore = HighscoreList.sharedInstance.highscores[indexPath.row]
        var identifier: String
        if highscore.mostRecent {
            identifier = "mostRecent"
        } else {
            identifier = "default"
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier)!
        cell.textLabel!.text = highscore.word
        cell.detailTextLabel!.text = "\(highscore.mistakes) mistakes"

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HighscoreList.sharedInstance.highscores.count
    }
}