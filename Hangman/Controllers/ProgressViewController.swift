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

        return cell
    }
}