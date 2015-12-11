//
//  ProgressViewController.swift
//  Hangman
//
//  Created by Pepijn Looije on 10/12/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Default", forIndexPath: indexPath) as! ProgressViewCell
        cell.letter.text = "B"
        return cell
    }
}