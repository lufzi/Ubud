//
//  UbudExampleUITests.swift
//  Ubud-ExampleUITests
//
//  Created by Luqman Fauzi on 11/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import XCTest

final class UbudExampleUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        super.tearDown()
    }
}
