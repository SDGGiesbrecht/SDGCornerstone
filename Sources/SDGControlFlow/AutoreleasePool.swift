/*
 AutoreleasePool.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if canImport(ObjectiveC)
@_exported import func ObjectiveC.autoreleasepool
#else
// MARK: - #if !canImport(ObjectiveC)

/// Allows code which autoreleases on Darwin to compile on Linux without the need for operating system checks.
///
/// This function does nothing on Linux, because Linux has no autoreleasing Objective‐C APIs to link against.
@inlinable public func autoreleasepool<Result>(invoking body: () throws -> Result) rethrows -> Result {
    return try body()
}
#endif
