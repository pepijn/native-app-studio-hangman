//
//  HighscoreListTests.swift
//  Hangman
//
//  Created by Pepijn Looije on 03/12/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import XCTest

class HighscoreListTests: XCTestCase {

    override func setUp() {
        super.setUp()

        HighscoreList.sharedInstance.reset()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testHighscores() {
        let word = "test"
        let mistakes = 3
        HighscoreList.sharedInstance.submitHighscore(word, mistakes: mistakes + 1)
        HighscoreList.sharedInstance.submitHighscore(word, mistakes: mistakes)
        XCTAssertEqual(HighscoreList.sharedInstance.highscores.count, 2)

        let bestHighscore = HighscoreList.sharedInstance.highscores.first!
        XCTAssert(bestHighscore.mostRecent)
        XCTAssertEqual(bestHighscore.word, "test")
        XCTAssertEqual(bestHighscore.mistakes, 3)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
