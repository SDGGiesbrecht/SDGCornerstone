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
@testable import SDGCornerstoneTests

XCTMain([
    testCase(AbsoluteValueExampleTests.allTests),
    testCase(ArbitraryPrecisionExampleTests.allTests),
    testCase(BoolExampleTests.allTests),
    testCase(CalendarExampleTests.allTests),
    testCase(ComparableExampleTests.allTests),
    testCase(DateExampleTests.allTests),
    testCase(DictionaryExampleTests.allTests),
    testCase(FunctionAnalysisExampleTests.allTests),
    testCase(PatternMatchingExampleTests.allTests),
    testCase(ReadMeExampleTests.allTests),
    testCase(RunLoopExampleTests.allTests),

    testCase(CachingTests.allTests),
    testCase(CollectionTests.allTests),
    testCase(ConcurrencyTests.allTests),
    testCase(DataTests.allTests),
    testCase(DateTests.allTests),
    testCase(EnumerationTests.allTests),
    testCase(GeometryTests.allTests),
    testCase(LogicTests.allTests),
    testCase(LocalizationTests.allTests),
    testCase(MathematicsTests.allTests),
    testCase(PersistenceTests.allTests),
    testCase(RandomizationTests.allTests),
    testCase(ReferenceTests.allTests),
    testCase(ShellTests.allTests),
    testCase(TextTests.allTests),

    testCase(RegressionTests.allTests),

    testCase(InternalTests.allTests),

    testCase(SDGControlFlowTests.allTests),
    testCase(SDGLogicTests.allTests),
    testCase(SDGBinaryDataTests.allTests),
    testCase(SDGMathematicsTests.allTests),
    testCase(SDGPersistenceTests.allTests),
    testCase(SDGProcessPropertiesTests.allTests)
])
