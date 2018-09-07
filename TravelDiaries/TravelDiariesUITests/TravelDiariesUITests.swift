//
//  TravelDiariesUITests.swift
//  TravelDiariesUITests
//
//  Created by Wipro on 07/09/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import XCTest
@testable import TravelDiaries

class TravelDiariesUITests: XCTestCase {


    override func setUp() {
        super.setUp()

        continueAfterFailure = true

        XCUIApplication().launch()

    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testUIScreenWithoutNetwork()
    {
        let app = XCUIApplication()
        XCTAssertTrue(app.alerts.staticTexts["connectivity issue"].exists)
    }

    func testUIScreenWithNetwork()
    {
        let app = XCUIApplication()
        XCTAssertFalse(app.alerts.staticTexts["connectivity issue"].exists)
        XCTAssertTrue(app.tables.cells.staticTexts["Flag"].exists)
        XCTAssertTrue(app.tables.cells.count >= 3)
        XCTAssertTrue(app.navigationBars.staticTexts["About Canada"].exists)
    }

}
