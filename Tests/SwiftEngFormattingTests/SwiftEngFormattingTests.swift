import XCTest
@testable import SwiftEngFormatting

// XCTest Documentation
// https://developer.apple.com/documentation/xctest

// Defining Test Cases and Test Methods
// https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods

final class SwiftEngFormattingTests: XCTestCase {
    func testFeetInchesFormatting() {
        XCTAssertEqual("\(ftin:5.833333333)", "5'-10\"")
        XCTAssertEqual("\(ftin:5.875)", "5'-10 1/2\"")
        XCTAssertEqual("\(ftin:5.90625)", "5'-10 7/8\"")
        XCTAssertEqual("\(ftin:5.90624)", "5'-10 7/8\"")
        XCTAssertEqual("\(ftin:-5.90624)", "-5'-10 7/8\"")
        XCTAssertEqual("\(ftin:0.515625)", "6 3/16\"")
        XCTAssertEqual("\(ftin:-0.515625)", "-6 3/16\"")
        XCTAssertEqual("\(ftin:0.75)", "9\"")
        XCTAssertEqual("\(ftin:0.0)", "0\"")
        XCTAssertEqual("\(ftin:-0.0)", "0\"")
        XCTAssertEqual("\(ftin:-0.75)", "-9\"")
        XCTAssertEqual("\(ftin:56.0/12.0)", "4'-8\"")
        XCTAssertEqual("\(ftin:-56.0/12.0)", "-4'-8\"")
    }
    
    func testSignificantDigitsFormatting() {
        XCTAssertEqual("\(sigdig:0.00543243)", "0.00543")
        XCTAssertEqual("\(sigdig2:0.00543243)", "0.0054")
        XCTAssertEqual("\(sigdig3:0.00543243)", "0.00543")
        XCTAssertEqual("\(sigdig4:0.00543243)", "0.005432")
    }
}
