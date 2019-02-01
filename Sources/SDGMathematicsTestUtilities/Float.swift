/*
 Float.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// Checks whether the two values are approximately equal.
///
/// - Parameters:
///     - precedingValue: A value to compare.
///     - followingValue: Another value to compare.
@inlinable public func ≈ <T>(precedingValue: T, followingValue: T) -> Bool where T : ExpressibleByFloatLiteral, T : FloatingPoint, T : Subtractable {
    return precedingValue ≈ followingValue ± 0.000_01
}

// MARK: - Methods

@inlinable public func test<T, R>(method: (call: (T) -> () throws -> R, name: String), of instance: T, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : ExpressibleByFloatLiteral, R : FloatingPoint, R : Subtractable {
    do {
        let result = try method.call(instance)()
        test(result ≈ expectedResult, "\(instance).\(method.name)() → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

@inlinable public func test<T, A, R>(method: (call: (T) -> (A) throws -> R, name: String), of instance: T, with argument: A, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : ExpressibleByFloatLiteral, R : FloatingPoint, R : Subtractable {
    do {
        let result = try method.call(instance)(argument)
        test(result ≈ expectedResult, "\(instance).\(method.name)(\(argument)) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

@inlinable public func test<T>(mutatingMethod method: (call: (inout T) throws -> Void, name: String), of instance: T, resultsIn expectedResult: T, file: StaticString = #file, line: UInt = #line) where T : ExpressibleByFloatLiteral, T : FloatingPoint, T : Subtractable {
    do {
        var copy = instance
        try method.call(&copy)
        test(copy ≈ expectedResult, "\(instance).\(method.name)() → \(copy) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

@inlinable public func test<T, A>(mutatingMethod method: (call: (inout T, A) throws -> Void, name: String), of instance: T, with argument: A, resultsIn expectedResult: T, file: StaticString = #file, line: UInt = #line) where T : ExpressibleByFloatLiteral, T : FloatingPoint, T : Subtractable {
    do {
        var copy = instance
        try method.call(&copy, argument)
        test(copy ≈ expectedResult, "\(instance).\(method.name)(\(argument)) → \(copy) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

// MARK: - Functions

@inlinable public func test<A, R>(function: (call: (A) throws -> R, name: String), on argument: A, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : ExpressibleByFloatLiteral, R : FloatingPoint, R : Subtractable {
    do {
        let result = try function.call(argument)
        test(result ≈ expectedResult, "\(function.name)(\(argument)) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

@inlinable public func test<A, B, R>(function: (call: (A, B) throws -> R, name: String), on arguments: (A, B), returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : ExpressibleByFloatLiteral, R : FloatingPoint, R : Subtractable {
    do {
        let result = try function.call(arguments.0, arguments.1)
        test(result ≈ expectedResult, "\(function.name)(\(arguments.0), \(arguments.1)) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

@inlinable public func test<A>(function: (call: (A) throws -> Angle<A>, name: String), on argument: A, returns expectedResult: Angle<A>, file: StaticString = #file, line: UInt = #line) where A : FloatingPoint {
    do {
        let result = try function.call(argument)
        test(result.rawValue ≈ expectedResult.rawValue, "\(function.name)(\(argument)) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

// MARK: - Operators

@inlinable public func test<P, F, R>(operator: (function: (P, F) throws -> R, name: String), on operands: (precedingValue: P, followingValue: F), returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : ExpressibleByFloatLiteral, R : FloatingPoint, R : Subtractable {
    do {
        let result = try `operator`.function(operands.precedingValue, operands.followingValue)
        test(result ≈ expectedResult, "\(operands.precedingValue) \(`operator`.name) \(operands.followingValue) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

@inlinable public func test<O, R>(prefixOperator operator: (function: (O) throws -> R, name: String), on operand: O, returns expectedResult: R, file: StaticString = #file, line: UInt = #line) where R : ExpressibleByFloatLiteral, R : FloatingPoint, R : Subtractable {
    do {
        let result = try `operator`.function(operand)
        test(result ≈ expectedResult, "\(`operator`.name)\(operand) → \(result) ≠ \(expectedResult)",
            file: file, line: line)
    } catch {
        fail("\(error)", file: file, line: line)
    }
}

@inlinable public func test<O>(postfixAssignmentOperator operator: (function: (inout O) throws -> Void, name: String), with operand: O, resultsIn expectedResult: O, file: StaticString = #file, line: UInt = #line) where O : ExpressibleByFloatLiteral, O : FloatingPoint, O : Subtractable {
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

@inlinable public func test<V>(variable: (contents: V, name: String), is expectedValue: V, file: StaticString = #file, line: UInt = #line) where V : ExpressibleByFloatLiteral, V : FloatingPoint, V : Subtractable {
    test(variable.contents ≈ expectedValue, "\(variable.name) → \(variable.contents) ≠ \(expectedValue)",
        file: file, line: line)
}
