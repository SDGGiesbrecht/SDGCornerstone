/*
 NumericAdditiveArithmetic.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SDGTesting

/// Tests a type’s conformance to NumericAdditiveArithmetic.
///
/// - Precondition: `augend` is expected to be less than `sum`.
///
/// - Precondition: `augend` is expected to be positive.
///
/// - Parameters:
///     - augend: A positive augend.
///     - addend: An addend.
///     - sum: The expected sum.
///     - includingNegatives: Whether or not to test negative numbers.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func testNumericAdditiveArithmeticConformance<T>(
  augend: T,
  addend: T,
  sum: T,
  includingNegatives: Bool,
  file: StaticString = #filePath,
  line: UInt = #line
) where T: NumericAdditiveArithmetic {

  testGenericAdditiveArithmeticConformance(
    augend: augend,
    addend: addend,
    sum: sum,
    file: file,
    line: line
  )
  testComparableConformance(less: augend, greater: sum, file: file, line: line)

  test(property: ({ $0.isPositive }, "isPositive"), of: T.zero, is: false, file: file, line: line)
  test(property: ({ $0.isPositive }, "isPositive"), of: augend, is: true, file: file, line: line)
  if includingNegatives {
    test(
      property: ({ $0.isPositive }, "isPositive"),
      of: T.zero − augend,
      is: false,
      file: file,
      line: line
    )
  }

  test(property: ({ $0.isNegative }, "isNegative"), of: T.zero, is: false, file: file, line: line)
  test(property: ({ $0.isNegative }, "isNegative"), of: augend, is: false, file: file, line: line)
  if includingNegatives {
    test(
      property: ({ $0.isNegative }, "isNegative"),
      of: T.zero − augend,
      is: true,
      file: file,
      line: line
    )
  }

  test(
    property: ({ $0.isNonNegative }, "isNonNegative"),
    of: T.zero,
    is: true,
    file: file,
    line: line
  )
  test(
    property: ({ $0.isNonNegative }, "isNonNegative"),
    of: augend,
    is: true,
    file: file,
    line: line
  )
  if includingNegatives {
    test(
      property: ({ $0.isNonNegative }, "isNonNegative"),
      of: T.zero − augend,
      is: false,
      file: file,
      line: line
    )
  }

  test(
    property: ({ $0.isNonPositive }, "isNonPositive"),
    of: T.zero,
    is: true,
    file: file,
    line: line
  )
  test(
    property: ({ $0.isNonPositive }, "isNonPositive"),
    of: augend,
    is: false,
    file: file,
    line: line
  )
  if includingNegatives {
    test(
      property: ({ $0.isNonPositive }, "isNonPositive"),
      of: T.zero − augend,
      is: true,
      file: file,
      line: line
    )
  }

  test(
    property: ({ $0.absoluteValue }, "absoluteValue"),
    of: augend,
    is: augend,
    file: file,
    line: line
  )
  if includingNegatives {
    test(
      property: ({ $0.absoluteValue }, "absoluteValue"),
      of: T.zero − augend,
      is: augend,
      file: file,
      line: line
    )
  }

  test(
    mutatingMethod: ({ $0.formAbsoluteValue() }, "formAbsoluteValue"),
    of: augend,
    resultsIn: augend,
    file: file,
    line: line
  )
  if includingNegatives {
    test(
      mutatingMethod: ({ $0.formAbsoluteValue() }, "formAbsoluteValue"),
      of: T.zero − augend,
      resultsIn: augend,
      file: file,
      line: line
    )
  }
}
