// MIT license. Copyright © 2017 Simon Strandgaard. All rights reserved.
import XCTest
@testable import SwiftySchwartzianTransform

class SchwartzianTransformTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SchwartzianTransform().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
