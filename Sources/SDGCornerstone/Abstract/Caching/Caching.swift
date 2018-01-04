/*
 Caching.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2016–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// MARK: - Caching

/// Returns the result of `computation`, using caching to improve efficiency upon repeated use.
///
/// This is accomplished by either...
///
/// - retrieving a previous result from `cache` (if `cache` is non‐`nil`), or
/// - executing `computation` and saving the result to `cache` before returning it.
///
/// - Parameters:
///     - cache: The variable in which to cache the result. Declare it in the appropriate scope for the desired cache lifetime. The cache can be refreshed at any time by setting it to `nil`.
///     - computation: The computation to be evaluated.
///
/// - Returns: The result of `computation`.
public func cached<Result>(in cache: inout Result?, _ computation: () throws -> Result) rethrows -> Result {
    if let result = cache {
        return result
    } else {
        let result = try computation()
        cache = result
        return result
    }
}
