/*
 Test.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// The assertion method used by `test(_:_:_:_:)`
public var testAssertionMethod: (_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String, _ file: StaticString, _ line: UInt) -> () = Swift.assert

/// Tests an expression, verifying that it is true.
@_inlineable public func test(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> () {

    testAssertionMethod(expression, message, file, line)
}
