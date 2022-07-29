@testable import SDGCollections2

import XCTest

final class InternalTests: XCTestCase {

  func testNestingContentsPattern() {
    let string = "...(...(...(...)...(...)...)...(...)...)..."
    let pattern = NestingPattern(opening: "(", closing: ")").contents
    XCTAssertNotNil(pattern.primaryMatch(in: string, at: string.dropFirst(3).startIndex))
  }
}
