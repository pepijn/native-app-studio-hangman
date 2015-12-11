//
//  ProgressViewController.swift
//  Hangman
//
//  Created by Pepijn Looije on 10/12/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var progress: Progress?

    var color: UIColor {
        if progress!.wonGame {
            return UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
        }

        let red = 1 - CGFloat(Float(progress!.remaining) / Float(progress!.total))
        return UIColor(red: red, green: 0, blue: 0, alpha: 1)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return progress!.progressSlots.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var identifier: String
        let progressSlot = progress!.progressSlots[indexPath.row]

        if progressSlot.filled {
            identifier = "Filled"
        } else if progressSlot.next {
            identifier = "Next"
        } else {
            identifier = "Default"
        }

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ProgressViewCell
        cell.letter.text = String(progressSlot.character).uppercaseString

        cell.letter.textColor = color

        return cell
    }
}