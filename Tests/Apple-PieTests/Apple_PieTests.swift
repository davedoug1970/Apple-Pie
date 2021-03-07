import XCTest
@testable import Apple_Pie

final class Apple_PieTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Apple_Pie().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
