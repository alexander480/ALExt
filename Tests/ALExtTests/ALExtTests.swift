import XCTest
@testable import ALExt

final class ALExtTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ALExt().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
