import XCTest

import SDGBinaryDataTests
import SDGCalendarTests
import SDGCollationTests
import SDGCollectionsTests
import SDGConcurrencyTests
import SDGControlFlowTests
import SDGCornerstoneDocumentationExampleTests
import SDGExternalProcessTests
import SDGGeometryTests
import SDGLocalizationTests
import SDGLogicTests
import SDGMathematicsTests
import SDGPersistenceTests
import SDGPrecisionMathematicsTests
import SDGRandomizationTests
import SDGTextTests
import SDGVersioningTests

var tests = [XCTestCaseEntry]()
tests += SDGBinaryDataTests.__allTests()
tests += SDGCalendarTests.__allTests()
tests += SDGCollationTests.__allTests()
tests += SDGCollectionsTests.__allTests()
tests += SDGConcurrencyTests.__allTests()
tests += SDGControlFlowTests.__allTests()
tests += SDGCornerstoneDocumentationExampleTests.__allTests()
tests += SDGExternalProcessTests.__allTests()
tests += SDGGeometryTests.__allTests()
tests += SDGLocalizationTests.__allTests()
tests += SDGLogicTests.__allTests()
tests += SDGMathematicsTests.__allTests()
tests += SDGPersistenceTests.__allTests()
tests += SDGPrecisionMathematicsTests.__allTests()
tests += SDGRandomizationTests.__allTests()
tests += SDGTextTests.__allTests()
tests += SDGVersioningTests.__allTests()

XCTMain(tests)
