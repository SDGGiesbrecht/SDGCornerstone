/*
 BidirectionalCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGMathematics

extension BidirectionalCollection {

    // @documentation(SDGCornerstone.BidirectionalCollection.index(before:))
    /// Returns the index immediately before the specified index.
    ///
    /// - Parameters:
    ///     - i: The following index.

    #if swift(>=4.1.50)
    // MARK: - #if swift(>=4.1.50)
    /// Returns the backward version of the specified range.
    @_inlineable public func backward<R>(_ range: R) -> Range<ReversedCollection<Self>.Index> where R : RangeExpression, R.Bound == Self.Index {
        let resolved = range.relative(to: self)
        return ReversedCollection<Self>.Index(resolved.upperBound) ..< ReversedCollection<Self>.Index(resolved.lowerBound)
    }

    /// Returns the forward version of the specified range.
    @_inlineable public func forward<R>(_ range: R) -> Range<Self.Index> where R : RangeExpression, R.Bound == ReversedCollection<Self>.Index {
        let resolved = range.relative(to: reversed())
        return resolved.upperBound.base ..< resolved.lowerBound.base
    }
    #endif
}
