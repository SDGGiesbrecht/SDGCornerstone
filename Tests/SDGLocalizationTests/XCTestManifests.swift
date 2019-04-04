#if !canImport(ObjectiveC)
import XCTest

extension SDGLocalizationAPITests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SDGLocalizationAPITests = [
        ("testAngle", testAngle),
        ("testBool", testBool),
        ("testCasing", testCasing),
        ("testCustomStringConvertible", testCustomStringConvertible),
        ("testLocalization", testLocalization),
        ("testLocalizationRelationships", testLocalizationRelationships),
        ("testLocalizationSetting", testLocalizationSetting),
        ("testRange", testRange),
        ("testRationalArithmetic", testRationalArithmetic),
        ("testUserFacingDynamicText", testUserFacingDynamicText),
        ("testWholeArithmetic", testWholeArithmetic),
    ]
}

extension SDGLocalizationInternalTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SDGLocalizationInternalTests = [
        ("testContentLocalization", testContentLocalization),
        ("testInterfaceLocalization", testInterfaceLocalization),
        ("testLocalizationSetting", testLocalizationSetting),
        ("testWholeNumber", testWholeNumber),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDGLocalizationAPITests.__allTests__SDGLocalizationAPITests),
        testCase(SDGLocalizationInternalTests.__allTests__SDGLocalizationInternalTests),
    ]
}
#endif
