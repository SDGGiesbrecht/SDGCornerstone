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
    // #workaround(Swift 4.1.2, This check can be removed in Swift 4.2)

    /// Returns the backward version of the specified range.
    @_inlineable public func backward(_ range: Range<Self.Index>) -> Range<ReversedCollection<Self>.Index> {
        return ReversedCollection<Self>.Index(range.upperBound) ..< ReversedCollection<Self>.Index(range.lowerBound)
    }

    /// Returns the forward version of the specified range.
    @_inlineable public func forward(_ range: Range<ReversedCollection<Self>.Index>) -> Range<Self.Index> {
        return range.upperBound.base ..< range.lowerBound.base
    }
    #endif
}
