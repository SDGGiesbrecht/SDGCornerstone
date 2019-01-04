import XCTest

extension TestCase {
    static let __allTests = [
        ("testLinuxMainGenerationCompatibility", testLinuxMainGenerationCompatibility),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TestCase.__allTests),
    ]
}
#endif
