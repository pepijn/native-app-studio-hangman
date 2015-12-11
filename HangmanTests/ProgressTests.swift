//
//  ProgressTests.swift
//  Hangman
//
//  Created by Pepijn Looije on 11/12/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import XCTest

class ProgressTests: XCTestCase {
    func testProgress() {
        var progress: Progress

        progress = Progress(mistakes: 0, remaining: 1)
        XCTAssertEqual(progress.extraACount, 0)

        progress = Progress(mistakes: 1, remaining: 1)
        XCTAssertEqual(progress.extraACount, 1)
        XCTAssertEqual(progress.description, "HANGmaan")

        progress = Progress(mistakes: 2, remaining: 1)
        XCTAssertEqual(progress.extraACount, 2)
        XCTAssertEqual(progress.description, "HANGMAaan")

        progress = Progress(mistakes: 0, remaining: 4)
        XCTAssertEqual(progress.extraACount, 1)

        progress = Progress(mistakes: 0, remaining: 5)
        XCTAssertEqual(progress.extraACount, 3)

        progress = Progress(mistakes: 0, remaining: 6)
        XCTAssertEqual(progress.extraACount, 5)

        progress = Progress(mistakes: 7, remaining: 0)
        XCTAssertEqual(progress.extraACount, 0)
        XCTAssertEqual(progress.description, "HANGMAN")

        progress = Progress(mistakes: 0, remaining: 8)
        XCTAssertEqual(progress.extraACount, 1)

        progress = Progress(mistakes: 7, remaining: 2)
        XCTAssertEqual(progress.extraACount, 2)
        XCTAssertEqual(progress.description, "HANGMAAan")

        progress = Progress(mistakes: 7, remaining: 0)
        XCTAssertEqual(progress.description, "HANGMAN")

        progress = Progress(mistakes: 0, remaining: 24)
        XCTAssertEqual(progress.extraACount, 17)
    }
}