#if !canImport(ObjectiveC)
import XCTest

extension DateExampleTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__DateExampleTests = [
        ("testCustomDate", testCustomDate),
    ]
}

extension FunctionAnalysisExampleTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FunctionAnalysisExampleTests = [
        ("testFindLocalMinimum", testFindLocalMinimum),
        ("testUndefinedCaseOneForFindLocalMaximum", testUndefinedCaseOneForFindLocalMaximum),
        ("testUndefinedCaseOneForFindLocalMinimum", testUndefinedCaseOneForFindLocalMinimum),
        ("testUndefinedCaseTwoForFindLocalMaximum", testUndefinedCaseTwoForFindLocalMaximum),
        ("testUndefinedCaseTwoForFindLocalMinimum", testUndefinedCaseTwoForFindLocalMinimum),
    ]
}

extension MiscellaneousExampleTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__MiscellaneousExampleTests = [
        ("testAbsoluteValue", testAbsoluteValue),
        ("testAlternatingBooleans", testAlternatingBooleans),
        ("testApproximation", testApproximation),
        ("testBackwardsSearchDifferences1", testBackwardsSearchDifferences1),
        ("testBackwardsSearchDifferences2", testBackwardsSearchDifferences2),
        ("testDecreasing", testDecreasing),
        ("testDictionaryMutation", testDictionaryMutation),
        ("testGregorianYear", testGregorianYear),
        ("testIncreasing", testIncreasing),
        ("testIntegerLiterals", testIntegerLiterals),
        ("testNestingLevel", testNestingLevel),
        ("testPatternSwitch", testPatternSwitch),
        ("testRationalNumberLiterals", testRationalNumberLiterals),
        ("testRunLoopUsage", testRunLoopUsage),
        ("testSetSwitch", testSetSwitch),
        ("testWholeNumberLiterals", testWholeNumberLiterals),
    ]
}

extension ReadMeExampleTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ReadMeExampleTests = [
        ("testReadMe", testReadMe),
    ]
}

extension StrictInterpolationExampleTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__StrictInterpolationExampleTests = [
        ("testStrictInterpolation", testStrictInterpolation),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DateExampleTests.__allTests__DateExampleTests),
        testCase(FunctionAnalysisExampleTests.__allTests__FunctionAnalysisExampleTests),
        testCase(MiscellaneousExampleTests.__allTests__MiscellaneousExampleTests),
        testCase(ReadMeExampleTests.__allTests__ReadMeExampleTests),
        testCase(StrictInterpolationExampleTests.__allTests__StrictInterpolationExampleTests),
    ]
}
#endif
