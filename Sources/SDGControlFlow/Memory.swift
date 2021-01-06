/*
 Memory.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(ObjectiveC)
  import ObjectiveC
#endif

/// Executes the closure, purging any autoreleased objects from memory afterward.
///
/// On platforms lacking Objective C, this function simply executes the closure.
///
/// - Parameters:
///     - closure: A closure to invoke.
@inlinable public func purgingAutoreleased<Result>(
  from closure: () throws -> Result
) rethrows -> Result {
  #if canImport(ObjectiveC)
    return try autoreleasepool(invoking: closure)
  #else
    return try closure()
  #endif
}
