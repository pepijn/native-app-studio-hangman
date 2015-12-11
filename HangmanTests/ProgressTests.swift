//
//  ProgressTests.swift
//  Hangman
//
//  Created by Pepijn Looije on 11/12/15.
//  Copyright © 2015 Pepijn Looije. All rights reserved.
//

import XCTest

class ProgressTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        var progress: Progress

        progress = Progress(mistakes: 0, remaining: 1)
        XCTAssertEqual(progress.extraACount, 0)

        progress = Progress(mistakes: 0, remaining: 2)
        XCTAssertEqual(progress.extraACount, 1)

        progress = Progress(mistakes: 0, remaining: 3)
        XCTAssertEqual(progress.extraACount, 2)

        progress = Progress(mistakes: 0, remaining: 4)
        XCTAssertEqual(progress.extraACount, 1)

        progress = Progress(mistakes: 0, remaining: 5)
        XCTAssertEqual(progress.extraACount, 3)

        progress = Progress(mistakes: 0, remaining: 6)
        XCTAssertEqual(progress.extraACount, 5)

        progress = Progress(mistakes: 0, remaining: 7)
        XCTAssertEqual(progress.extraACount, 0)

        progress = Progress(mistakes: 0, remaining: 8)
        XCTAssertEqual(progress.extraACount, 1)

        progress = Progress(mistakes: 0, remaining: 9)
        XCTAssertEqual(progress.extraACount, 2)

        progress = Progress(mistakes: 7, remaining: 0)
        XCTAssertEqual(progress.description, "HANGMAN")

        progress = Progress(mistakes: 1, remaining: 1)
        //XCTAssertEqual(progress.description, "HANGmaan")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
}