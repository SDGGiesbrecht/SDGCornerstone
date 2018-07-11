/*
 Test.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// MARK: - General

private func defaultTestAssertionMethod(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String, file: StaticString, line: UInt) { // @exempt(from: tests)
    if expression() {} else { // @exempt(from: tests)
        // Release optimization removes assert and strips precondition’s message.
        fatalError(message(), file: file, line: line)
    }
}

/// The assertion method used by `test(_:_:_:_:)`
public var testAssertionMethod: (_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String, _ file: StaticString, _ line: UInt) -> Void = defaultTestAssertionMethod

/// Tests an expression, verifying that it is true.
@_inlineable public func test(_ expression: @autoclosure () throws -> Bool, _ message: @autoclosure () throws -> String, file: StaticString = #file, line: UInt = #line) {

    testAssertionMethod({
        do {
            return try expression()
        } catch { // @exempt(from: tests)
            testAssertionMethod(false, "\(error)", file, line) // Fails with the error message.
            return true // No need to fail twice.
        }
    }(), { // @exempt(from: tests)
        do { // @exempt(from: tests)
            return try message()
        } catch { // @exempt(from: tests)
            return "\(error)" // Message resolution failed. Use the error description.
        }
    }(), file, line)
}

/// Fails a test.
@_inlineable public func fail(_ message: @autoclosure () throws -> String, file: StaticString = #file, line: UInt = #line) {
    test(false, message, file: file, line: line)
}

// MARK: - Methods

/// Tests a method, verifying that it returns the expected result.
@_inlineable public func test<T, R>(method: (method: (T) -> () throws -> R, name: String), of instance: T, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : Equatable {
    do {
        let result = try method.method(instance)()
        test(result == expectedResult, "\(instance).\(method.name)() → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a method, verifying that it returns the expected result.
@_inlineable public func test<T, A, R>(method: (method: (T) -> (A) throws -> R, name: String), of instance: T, with argument: A, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : Equatable {
    do {
        let result = try method.method(instance)(argument)
        test(result == expectedResult, "\(instance).\(method.name)(\(argument)) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a method, verifying that it returns the expected result.
@_inlineable public func test<T, A, B, R>(method: (method: (T) -> (A, B) throws -> R, name: String), of instance: T, with arguments: (A, B), returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : Equatable {
    do {
        let result = try method.method(instance)(arguments.0, arguments.1)
        test(result == expectedResult, "\(instance).\(method.name)(\(arguments.0), \(arguments.1)) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a method, verifying that it returns the expected result.
@_inlineable public func test<T>(mutatingMethod method: (method: (inout T) -> () throws -> Void, name: String), of instance: T, resultsIn expectedResult: T, file: StaticString = #file, line: UInt = #line) where T : Equatable {
    do {
        var copy = instance
        try method.method(&copy)()
        test(copy == expectedResult, "\(instance).\(method.name)() → \(copy) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a method, verifying that it returns the expected result.
@_inlineable public func test<T, A>(mutatingMethod method: (method: (inout T) -> (A) throws -> Void, name: String), of instance: T, with argument: A, resultsIn expectedResult: T, file: StaticString = #file, line: UInt = #line) where T : Equatable {
    do {
        var copy = instance
        try method.method(&copy)(argument)
        test(copy == expectedResult, "\(instance).\(method.name)(\(argument)) → \(copy) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a method, verifying that it returns the expected result.
@_inlineable public func test<T, A, B>(mutatingMethod method: (method: (inout T) -> (A, B) throws -> Void, name: String), of instance: T, with arguments: (A, B), resultsIn expectedResult: T, file: StaticString = #file, line: UInt = #line) where T : Equatable {
    do {
        var copy = instance
        try method.method(&copy)(arguments.0, arguments.1)
        test(copy == expectedResult, "\(instance).\(method.name)(\(arguments.0), \(arguments.1)) → \(copy) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

// MARK: - Functions

/// Tests a function, verifying that it returns the expected result.
@_inlineable public func test<A, R>(function: (function: (A) throws -> R, name: String), on argument: A, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : Equatable {
    do { // @exempt(from: tests)
        let result = try function.function(argument)
        test(result == expectedResult, "\(function.name)(\(argument)) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a function, verifying that it returns the expected result.
@_inlineable public func test<A, B, R>(function: (function: (A, B) throws -> R, name: String), on arguments: (A, B), returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : Equatable {
    do {
        let result = try function.function(arguments.0, arguments.1)
        test(result == expectedResult, "\(function.name)(\(arguments.0), \(arguments.1)) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

// MARK: - Operators

/// Tests an infix operator, verifying that it returns the expected result.
@_inlineable public func test<P, F, R>(operator: (function: (P, F) throws -> R, name: String), on operands: (precedingValue: P, followingValue: F), returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : Equatable {
    do {
        let result = try `operator`.function(operands.precedingValue, operands.followingValue)
        test(result == expectedResult, "\(operands.precedingValue) \(`operator`.name) \(operands.followingValue) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests an infix operator, verifying that it returns the expected result.
@_inlineable public func test<P, F, R, S>(operator: (function: (P, F) throws -> (R, S), name: String), on operands: (precedingValue: P, followingValue: F), returns expectedResult: (R, S), file: StaticString = #file, line: UInt = #line) where R : Equatable, S : Equatable {
    do {
        let result = try `operator`.function(operands.precedingValue, operands.followingValue)
        test(result == expectedResult, "\(operands.precedingValue) \(`operator`.name) \(operands.followingValue) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests an infix operator, verifying that it returns the expected result.
@_inlineable public func test<P, F, R>(operator: (function: (P, @autoclosure () throws -> F) throws -> R, name: String), on precedingValue: P, _ followingValue: @autoclosure () throws -> F, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : Equatable {
    do {
        let result = try `operator`.function(precedingValue, followingValue)
        test(result == expectedResult, "\(precedingValue) \(`operator`.name) \(try followingValue()) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests an infix assignment operator, verifying that the mutated value matches the expected result.
@_inlineable public func test<P, F>(assignmentOperator operator: (function: (inout P, F) throws -> Void, name: String), with operands: (precedingValue: P, followingValue: F), resultsIn expectedResult: P, file: StaticString = #file, line: UInt = #line) where P : Equatable {
    do {
        var copy = operands.precedingValue
        try `operator`.function(&copy, operands.followingValue)
        test(copy == expectedResult, "\(operands.precedingValue) \(`operator`.name) \(operands.followingValue) → \(copy) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests an infix assignment operator, verifying that the mutated value matches the expected result.
@_inlineable public func test<P, F>(assignmentOperator operator: (function: (inout P, @autoclosure () throws -> F) throws -> Void, name: String), with precedingValue: P, _ followingValue: @autoclosure () throws -> F, resultsIn expectedResult: P, file: StaticString = #file, line: UInt = #line) where P : Equatable {
    do {
        var copy = precedingValue
        try `operator`.function(&copy, followingValue)
        test(copy == expectedResult, "\(precedingValue) \(`operator`.name) \(try followingValue()) → \(copy) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a prefix operator, verifying that it returns the expected result.
@_inlineable public func test<O, R>(prefixOperator operator: (function: (O) throws -> R, name: String), on operand: O, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : Equatable {
    do {
        let result = try `operator`.function(operand)
        test(result == expectedResult, "\(`operator`.name)\(operand) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a postfix operator, verifying that it returns the expected result.
@_inlineable public func test<O, R>(postfixOperator operator: (function: (O) throws -> R, name: String), on operand: O, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : Equatable {
    do { // @exempt(from: tests)
        let result = try `operator`.function(operand)
        test(result == expectedResult, "\(operand)\(`operator`.name) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a postfix assignment operator, verifying that the mutated value matches the expected result.
@_inlineable public func test<O>(postfixAssignmentOperator operator: (function: (inout O) throws -> Void, name: String), with operand: O, resultsIn expectedResult: O, file: StaticString = #file, line: UInt = #line) where O : Equatable {
    do {
        var copy = operand
        try `operator`.function(&copy)
        test(copy == expectedResult, "\(operand)\(`operator`.name) → \(copy) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

// MARK: - Properties

/// Tests a property of an instance, verifying that it contains the expected value.
@_inlineable public func test<T, P>(property: (accessor: (T) -> P, name: String), of instance: T, is expectedValue: P, file: StaticString = #file, line: UInt = #line) where P : Equatable {
    let contents = property.accessor(instance)
    test(contents == expectedValue, "\(instance).\(property.name) → \(contents) ≠ \(expectedValue)",
        file: file, line: line)
}

// MARK: - Global Variables

/// Tests a variable, verifying that it contains the expected value.
@_inlineable public func test<V>(variable: (contents: V, name: String), is expectedValue: V, file: StaticString = #file, line: UInt = #line) where V : Equatable {
    test(variable.contents == expectedValue, "\(variable.name) → \(variable.contents) ≠ \(expectedValue)",
        file: file, line: line)
}
