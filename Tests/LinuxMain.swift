/*
 LinuxMain.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import XCTest
@testable import SDGControlFlowTests
@testable import SDGLogicTests
@testable import SDGMathematicsTests
@testable import SDGBinaryDataTests
@testable import SDGCollectionsTests
@testable import SDGTextTests
@testable import SDGPersistenceTests
@testable import SDGRandomizationTests
@testable import SDGLocalizationTests
@testable import SDGGeometryTests
@testable import SDGCalendarTests
@testable import SDGPrecisionMathematicsTests
@testable import SDGConcurrencyTests
@testable import SDGExternalProcessTests
@testable import SDGCornerstoneDocumentationExampleTests

XCTMain([

    testCase(SDGControlFlowAPITests.allTests),

    testCase(SDGLogicAPITests.allTests),

    testCase(SDGMathematicsAPITests.allTests),
    testCase(SDGMathematicsRegressionTests.allTests),

    testCase(SDGCollectionsAPITests.allTests),

    testCase(SDGBinaryDataAPITests.allTests),

    testCase(SDGTextAPITests.allTests),
    testCase(SDGTextInternalTests.allTests),
    testCase(SDGTextRegressionTests.allTests),

    testCase(SDGPersistenceAPITests.allTests),
    testCase(SDGPersistenceRegressionTests.allTests),

    testCase(SDGRandomizationAPITests.allTests),

    testCase(SDGLocalizationAPITests.allTests),
    testCase(SDGLocalizationInternalTests.allTests),

    testCase(SDGGeometryAPITests.allTests),

    testCase(SDGCalendarAPITests.allTests),
    testCase(SDGCalendarInternalTests.allTests),
    testCase(SDGCalendarRegressionTests.allTests),

    testCase(SDGPrecisionMathematicsAPITests.allTests),
    testCase(SDGPrecisionMathematicsInternalTests.allTests),

    testCase(SDGConcurrencyAPITests.allTests),

    testCase(SDGExternalProcessAPITests.allTests),
    testCase(SDGExternalProcessRegressionTests.allTests),

    testCase(ReadMeExampleTests.allTests),
    testCase(MiscellaneousExampleTests.allTests),
    testCase(DateExampleTests.allTests),
    testCase(FunctionAnalysisExampleTests.allTests)
])
