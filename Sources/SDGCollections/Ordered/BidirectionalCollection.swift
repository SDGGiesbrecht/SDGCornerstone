/*
 BidirectionalCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

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

    /// Returns the backward version of the specified range.
    @inlinable public func backward<R>(_ range: R) -> Range<ReversedCollection<Self>.Index> where R : RangeExpression, R.Bound == Self.Index {
        let resolved = range.relative(to: self)
        return ReversedCollection<Self>.Index(resolved.upperBound) ..< ReversedCollection<Self>.Index(resolved.lowerBound)
    }

    // #workaround(workspace version 0.15.0, SwiftSyntax crashes if this is used directly.)
    public typealias _ReversedCollectionSelf = ReversedCollection<Self>
    /// Returns the forward version of the specified range.
    @inlinable public func forward<R>(_ range: R) -> Range<Self.Index> where R : RangeExpression, R.Bound == _ReversedCollectionSelf.Index {
        let resolved = range.relative(to: reversed())
        return resolved.upperBound.base ..< resolved.lowerBound.base
    }
}
