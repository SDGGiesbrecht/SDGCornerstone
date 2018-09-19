/*
 LineViewIndex.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A line view index.
public struct LineViewIndex : Comparable, Equatable {

    // MARK: - Initialization

    @_versioned internal init(start: String.ScalarView.Index, newline: Range<String.ScalarView.Index>? = nil) {
        self.start = start
        cache.newline = newline
    }

    private init() {
        start = nil
    }
    @_versioned internal static func endIndex() -> LineViewIndex {
        return LineViewIndex()
    }

    // MARK: - Properties

    @_versioned internal class Cache {
        fileprivate init() {}
        @_versioned internal var newline: Range<String.ScalarView.Index>?
    }
    @_versioned internal var cache = Cache()

    @_versioned internal let start: String.ScalarView.Index? // nil indicates the end index

    @_specialize(exported: true, where S == StrictString.ScalarView)
    @_specialize(exported: true, where S == String.ScalarView)
    @inlinable @_versioned internal func newline<S : UnicodeScalarView>(in scalars: S) -> Range<String.ScalarView.Index>? {
        guard let startIndex = start else {
            return nil
        }
        return cached(in: &cache.newline) {
            return scalars[startIndex...].firstMatch(for: CharacterSet.newlinePattern)?.range ?? scalars.endIndex ..< scalars.endIndex
        }
    }

    // MARK: - Conversions

    /// Returns the position in the given view of scalars that corresponds exactly to this index.
    @inlinable public func samePosition(in scalars: StrictString) -> StrictString.Index {
        return start ?? scalars.endIndex
    }

    /// Returns the position in the given view of scalars that corresponds exactly to this index.
    @inlinable public func samePosition(in scalars: String.ScalarView) -> String.ScalarView.Index {
        return start ?? scalars.endIndex
    }

    /// Returns the position in the given view of clusters that corresponds exactly to this index.
    @inlinable public func samePosition(in clusters: StrictString.ClusterView) -> StrictString.ClusterView.Index {
        return samePosition(in: String(StrictString(clusters)).clusters)
    }

    /// Returns the position in the given view of clusters that corresponds exactly to this index.
    @inlinable public func samePosition(in clusters: String.ClusterView) -> String.ClusterView.Index {
        let string = String(clusters)
        return samePosition(in: string.scalars).cluster(in: string.clusters)
    }

    // MARK: - Comparable

    // #documentation(SDGCornerstone.Comparable.<)
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    @inlinable public static func < (precedingValue: LineViewIndex, followingValue: LineViewIndex) -> Bool {
        if let precedingValueStart = precedingValue.start {
            if let followingValueStart = followingValue.start {
                return precedingValueStart < followingValueStart
            } else {
                // precedingValue is valid, but followingValue is the end index.
                return true
            }
        } else {
            // precedingValue is the end index.
            return false
        }
    }

    // MARK: - Equatable

    // #documentation(SDGCornerstone.Equatable.==)
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    @inlinable public static func == (precedingValue: LineViewIndex, followingValue: LineViewIndex) -> Bool {
        return precedingValue.start == followingValue.start
    }
}
