/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

import SDGTesting

/// Checks whether the two values are approximately equal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@inlinable public func ≈ <T>(precedingValue: T, followingValue: T) -> Bool
where T: ExpressibleByFloatLiteral, T: FloatingPoint, T: Subtractable {
  return precedingValue ≈ followingValue ± 0.000_01
}

// MARK: - Methods

// #documentation(SDGCornerstone.test(method:of:returns:))
/// Tests a method, verifying that it returns the expected result.
///
/// - Parameters:
///     - method: The method to test.
///     - call: The method itself.
///     - methodInstance: The instance on which to call the method.
///     - name: The method name.
///     - instance: The instance on which to call the method.
///     - expectedResult: The expected result.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
@inlinable public func test<T, R>(
  method: (call: (_ methodInstance: T) -> () throws -> R, name: String),
  of instance: T,
  returns expectedResult: R,
  file: StaticString = #file,
  line: UInt = #line
) where R: ExpressibleByFloatLiteral, R: FloatingPoint, R: Subtractable {
  do {
    let result = try method.call(instance)()
    test(
      result ≈ expectedResult,
      "\(instance).\(method.name)() → \(result) ≠ \(expectedResult)",
      file: file,
      line: line
    )
  } catch {
    fail("\(error)", file: file, line: line)
  }
}

// #documentation(SDGCornerstone.test(method:of:with:returns:))
/// Tests a method, verifying that it returns the expected result.
///
/// - Parameters:
///     - method: The method to test.
///     - call: The method itself.
///     - methodInstance: The instance on which to call the method.
///     - name: The method name.
///     - instance: The instance on which to call the method.
///     - argument: The argument to pass to the method.
///     - expectedResult: The expected result.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
@inlinable public func test<T, A, R>(
  method: (call: (_ methodInstance: T) -> (_ methodArgument: A) throws -> R, name: String),
  of instance: T,
  with argument: A,
  returns expectedResult: R,
  file: StaticString = #file,
  line: UInt = #line
) where R: ExpressibleByFloatLiteral, R: FloatingPoint, R: Subtractable {
  do {
    let result = try method.call(instance)(argument)
    test(
      result ≈ expectedResult,
      "\(instance).\(method.name)(\(argument)) → \(result) ≠ \(expectedResult)",
      file: file,
      line: line
    )
  } catch {
    fail("\(error)", file: file, line: line)
  }
}

// #documentation(SDGCornerstone.test(mutatingMethod:of:resultsIn:))
/// Tests a method, verifying that it returns the expected result.
///
/// - Parameters:
///     - method: The method to test.
///     - call: The method itself.
///     - methodInstance: The instance on which to call the method.
///     - name: The method name.
///     - instance: The instance on which to call the method.
///     - expectedResult: The expected result.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
@inlinable public func test<T>(
  mutatingMethod method: (call: (_ methodInstance: inout T) throws -> Void, name: String),
  of instance: T,
  resultsIn expectedResult: T,
  file: StaticString = #file,
  line: UInt = #line
) where T: ExpressibleByFloatLiteral, T: FloatingPoint, T: Subtractable {
  do {
    var copy = instance
    try method.call(&copy)
    test(
      copy ≈ expectedResult,
      "\(instance).\(method.name)() → \(copy) ≠ \(expectedResult)",
      file: file,
      line: line
    )
  } catch {
    fail("\(error)", file: file, line: line)
  }
}

// #documentation(SDGCornerstone.test(mutatingMethod:of:with:resultsIn:))
/// Tests a method, verifying that it returns the expected result.
///
/// - Parameters:
///     - method: The method to test.
///     - call: The method itself.
///     - methodInstance: The instance on which to call the method.
///     - methodArgument: An argument to pass to the method.
///     - name: The method name.
///     - instance: The instance on which to call the method.
///     - argument: The argument to pass to the method.
///     - expectedResult: The expected result.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
@inlinable public func test<T, A>(
  mutatingMethod method: (
    call: (_ methodInstance: inout T, _ methodArgument: A) throws -> Void, name: String
  ),
  of instance: T,
  with argument: A,
  resultsIn expectedResult: T,
  file: StaticString = #file,
  line: UInt = #line
) where T: ExpressibleByFloatLiteral, T: FloatingPoint, T: Subtractable {
  do {
    var copy = instance
    try method.call(&copy, argument)
    test(
      copy ≈ expectedResult,
      "\(instance).\(method.name)(\(argument)) → \(copy) ≠ \(expectedResult)",
      file: file,
      line: line
    )
  } catch {
    fail("\(error)", file: file, line: line)
  }
}

// MARK: - Functions

// #documentation(SDGCornerstone.test(function:on:returns:))
/// Tests a function, verifying that it returns the expected result.
///
/// - Parameters:
///     - function: The function to test.
///     - call: The function itself.
///     - functionArgument: An argument to pass to the function.
///     - name: The function name.
///     - argument: The argument to pass to the function.
///     - expectedResult: The expected result.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
@inlinable public func test<A, R>(
  function: (call: (_ functionArgument: A) throws -> R, name: String),
  on argument: A,
  returns expectedResult: R,
  file: StaticString = #file,
  line: UInt = #line
) where R: ExpressibleByFloatLiteral, R: FloatingPoint, R: Subtractable {
  do {
    let result = try function.call(argument)
    test(
      result ≈ expectedResult,
      "\(function.name)(\(argument)) → \(result) ≠ \(expectedResult)",
      file: file,
      line: line
    )
  } catch {
    fail("\(error)", file: file, line: line)
  }
}

// #documentation(SDGCornerstone.test(function:on:(2)returns:))
/// Tests a function, verifying that it returns the expected result.
///
/// - Parameters:
///     - function: The function to test.
///     - call: The function itself.
///     - firstFunctionArgument: An argument to pass to the function.
///     - secondFunctionArgument: An argument to pass to the function.
///     - name: The function name.
///     - arguments: The arguments to pass to the function.
///     - expectedResult: The expected result.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
@inlinable public func test<A, B, R>(
  function: (
    call: (_ firstFunctionArgument: A, _ secondFunctionArgument: B) throws -> R, name: String
  ),
  on arguments: (A, B),
  returns expectedResult: R,
  file: StaticString = #file,
  line: UInt = #line
) where R: ExpressibleByFloatLiteral, R: FloatingPoint, R: Subtractable {
  do {
    let result = try function.call(arguments.0, arguments.1)
    test(
      result ≈ expectedResult,
      "\(function.name)(\(arguments.0), \(arguments.1)) → \(result) ≠ \(expectedResult)",
      file: file,
      line: line
    )
  } catch {
    fail("\(error)", file: file, line: line)
  }
}

// #documentation(SDGCornerstone.test(function:on:returns:))
/// Tests a function, verifying that it returns the expected result.
///
/// - Parameters:
///     - function: The function to test.
///     - call: The function itself.
///     - functionArgument: An argument to pass to the function.
///     - name: The function name.
///     - argument: The argument to pass to the function.
///     - expectedResult: The expected result.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
@inlinable public func test<A>(
  function: (call: (_ functionArgument: A) throws -> Angle<A>, name: String),
  on argument: A,
  returns expectedResult: Angle<A>,
  file: StaticString = #file,
  line: UInt = #line
) where A: FloatingPoint {
  do {
    let result = try function.call(argument)
    test(
      result.rawValue ≈ expectedResult.rawValue,
      "\(function.name)(\(argument)) → \(result) ≠ \(expectedResult)",
      file: file,
      line: line
    )
  } catch {
    fail("\(error)", file: file, line: line)
  }
}

// MARK: - Operators

// #documentation(SDGCornerstone.test(operator:on:returns:))
/// Tests an infix operator, verifying that it returns the expected result.
///
/// - Parameters:
///     - operator: The operator function to test.
///     - function: The function itself.
///     - precedingOperand: The preceding operand.
///     - followingOperand: The following operand.
///     - name: The function name.
///     - operands: The operands to pass to the function.
///     - precedingValue: The preceding operand.
///     - followingValue: The following operand.
///     - expectedResult: The expected result.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
@inlinable public func test<P, F, R>(
  operator: (function: (_ precedingOperand: P, _ followingOperand: F) throws -> R, name: String),
  on operands: (precedingValue: P, followingValue: F),
  returns expectedResult: R,
  file: StaticString = #file,
  line: UInt = #line
) where R: ExpressibleByFloatLiteral, R: FloatingPoint, R: Subtractable {
  do {
    let result = try `operator`.function(operands.precedingValue, operands.followingValue)
    test(
      result ≈ expectedResult,
      "\(operands.precedingValue) \(`operator`.name) \(operands.followingValue) → \(result) ≠ \(expectedResult)",
      file: file,
      line: line
    )
  } catch {
    fail("\(error)", file: file, line: line)
  }
}

// #documentation(SDGCornerstone.test(prefixOperator:on:returns:))
/// Tests a prefix operator, verifying that it returns the expected result.
///
/// - Parameters:
///     - operator: The operator function to test.
///     - function: The function itself.
///     - functionOperand: The operand to pass to the function.
///     - name: The function name.
///     - operand: The operand to pass to the function.
///     - expectedResult: The expected result.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
@inlinable public func test<O, R>(
  prefixOperator operator: (function: (_ functionOperand: O) throws -> R, name: String),
  on operand: O,
  returns expectedResult: R,
  file: StaticString = #file,
  line: UInt = #line
) where R: ExpressibleByFloatLiteral, R: FloatingPoint, R: Subtractable {
  do {
    let result = try `operator`.function(operand)
    test(
      result ≈ expectedResult,
      "\(`operator`.name)\(operand) → \(result) ≠ \(expectedResult)",
      file: file,
      line: line
    )
  } catch {
    fail("\(error)", file: file, line: line)
  }
}

// #documentation(SDGCornerstone.test(postfixAssignmentOperator:with:resultsIn:))
/// Tests a postfix assignment operator, verifying that the mutated value matches the expected result.
///
/// - Parameters:
///     - operator: The operator function to test.
///     - function: The function itself.
///     - functionOperand: The operand to pass to the function.
///     - name: The function name.
///     - operand: The operand to pass to the function.
///     - expectedResult: The expected result.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
@inlinable public func test<O>(
  postfixAssignmentOperator operator: (
    function: (_ functionOperand: inout O) throws -> Void, name: String
  ),
  with operand: O,
  resultsIn expectedResult: O,
  file: StaticString = #file,
  line: UInt = #line
) where O: ExpressibleByFloatLiteral, O: FloatingPoint, O: Subtractable {
  do {
    var copy = operand
    try `operator`.function(&copy)
    test(
      copy ≈ expectedResult,
      "\(operand)\(`operator`.name) → \(copy) ≠ \(expectedResult)",
      file: file,
      line: line
    )
  } catch {
    fail("\(error)", file: file, line: line)
  }
}

// MARK: - Global Variables

// #documentation(SDGCornerstone.test(variable:is:))
/// Tests a variable, verifying that it contains the expected value.
///
/// - Parameters:
///     - variable: The variable to test.
///     - contents: The variable itself.
///     - name: The name of the variable.
///     - expectedValue: The expected property value.
///     - file: Optional. A different source file to associate with any failures.
///     - line: Optional. A different line to associate with any failures.
public func test<V>(
  variable: (contents: V, name: String),
  is expectedValue: V,
  file: StaticString = #file,
  line: UInt = #line
) where V: ExpressibleByFloatLiteral, V: FloatingPoint, V: Subtractable {
  test(
    variable.contents ≈ expectedValue,
    "\(variable.name) → \(variable.contents) ≠ \(expectedValue)",
    file: file,
    line: line
  )
}
