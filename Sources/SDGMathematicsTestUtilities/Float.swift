/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Checks whether the two values are approximately equal.
@_inlineable public func ≈ <T>(precedingValue: T, followingValue: T) -> Bool where T : ExpressibleByFloatLiteral, T : FloatingPoint, T : Subtractable {
    return precedingValue ≈ followingValue ± 0.000_01
}

// MARK: - Methods

/// Tests a method, verifying that it returns the expected result.
@_inlineable public func test<T, R>(method: (method: (T) -> () throws -> R, name: String), of instance: T, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : ExpressibleByFloatLiteral, R : FloatingPoint, R : Subtractable {
    do {
        let result = try method.method(instance)()
        test(result ≈ expectedResult, "\(instance).\(method.name)() → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a method, verifying that it returns the expected result.
@_inlineable public func test<T, A, R>(method: (method: (T) -> (A) throws -> R, name: String), of instance: T, with argument: A, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : ExpressibleByFloatLiteral, R : FloatingPoint, R : Subtractable {
    do {
        let result = try method.method(instance)(argument)
        test(result ≈ expectedResult, "\(instance).\(method.name)(\(argument)) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a method, verifying that it returns the expected result.
@_inlineable public func test<T>(mutatingMethod method: (method: (inout T) throws -> Void, name: String), of instance: T, resultsIn expectedResult: T, file: StaticString = #file, line: UInt = #line) where T : ExpressibleByFloatLiteral, T : FloatingPoint, T : Subtractable {
    do {
        var copy = instance
        try method.method(&copy)
        test(copy ≈ expectedResult, "\(instance).\(method.name)() → \(copy) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a method, verifying that it returns the expected result.
@_inlineable public func test<T, A>(mutatingMethod method: (method: (inout T, A) throws -> Void, name: String), of instance: T, with argument: A, resultsIn expectedResult: T, file: StaticString = #file, line: UInt = #line) where T : ExpressibleByFloatLiteral, T : FloatingPoint, T : Subtractable {
    do {
        var copy = instance
        try method.method(&copy, argument)
        test(copy ≈ expectedResult, "\(instance).\(method.name)(\(argument)) → \(copy) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

// MARK: - Functions

/// Tests a function, verifying that it returns the expected result.
@_inlineable public func test<A, R>(function: (function: (A) throws -> R, name: String), on argument: A, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : ExpressibleByFloatLiteral, R : FloatingPoint, R : Subtractable {
    do {
        let result = try function.function(argument)
        test(result ≈ expectedResult, "\(function.name)(\(argument)) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a function, verifying that it returns the expected result.
@_inlineable public func test<A, B, R>(function: (function: (A, B) throws -> R, name: String), on arguments: (A, B), returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : ExpressibleByFloatLiteral, R : FloatingPoint, R : Subtractable {
    do {
        let result = try function.function(arguments.0, arguments.1)
        test(result ≈ expectedResult, "\(function.name)(\(arguments.0), \(arguments.1)) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a function, verifying that it returns the expected result.
@_inlineable public func test<A>(function: (function: (A) throws -> Angle<A>, name: String), on argument: A, returns expectedResult: Angle<A>, file: StaticString = #file, line: UInt = #line) where A : FloatingPoint {
    do {
        let result = try function.function(argument)
        test(result.rawValue ≈ expectedResult.rawValue, "\(function.name)(\(argument)) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

// MARK: - Operators

/// Tests an infix operator, verifying that it returns the expected result.
@_inlineable public func test<P, F, R>(operator: (function: (P, F) throws -> R, name: String), on operands: (precedingValue: P, followingValue: F), returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : ExpressibleByFloatLiteral, R : FloatingPoint, R : Subtractable {
    do {
        let result = try `operator`.function(operands.precedingValue, operands.followingValue)
        test(result ≈ expectedResult, "\(operands.precedingValue) \(`operator`.name) \(operands.followingValue) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a prefix operator, verifying that it returns the expected result.
@_inlineable public func test<O, R>(prefixOperator operator: (function: (O) throws -> R, name: String), on operand: O, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : ExpressibleByFloatLiteral, R : FloatingPoint, R : Subtractable {
    do {
        let result = try `operator`.function(operand)
        test(result ≈ expectedResult, "\(`operator`.name)\(operand) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

/// Tests a postfix assignment operator, verifying that the mutated value matches the expected result.
@_inlineable public func test<O>(postfixAssignmentOperator operator: (function: (inout O) throws -> Void, name: String), with operand: O, resultsIn expectedResult: O, file: StaticString = #file, line: UInt = #line) where O : ExpressibleByFloatLiteral, O : FloatingPoint, O : Subtractable {
    do {
        var copy = operand
        try `operator`.function(&copy)
        test(copy ≈ expectedResult, "\(operand)\(`operator`.name) → \(copy) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

// MARK: - Global Variables

/// Tests a variable, verifying that it contains the expected value.
@_inlineable public func test<V>(variable: (contents: V, name: String), is expectedValue: V, file: StaticString = #file, line: UInt = #line) where V : ExpressibleByFloatLiteral, V : FloatingPoint, V : Subtractable {
    test(variable.contents ≈ expectedValue, "\(variable.name) → \(variable.contents) ≠ \(expectedValue)",
        file: file, line: line)
}
