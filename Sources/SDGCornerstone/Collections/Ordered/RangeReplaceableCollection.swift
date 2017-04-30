/*
 RangeReplaceableCollection.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension RangeReplaceableCollection {

    /// Appends the elements of the right collection to the left collection.
    ///
    /// - Parameters:
    ///     - lhs: The collection to modify.
    ///     - rhs: The collection to append.
    ///
    /// - NonmutatingVariant: `+`
    public static func +=<S : Sequence>(lhs: inout Self, rhs: S) where S.Iterator.Element == Iterator.Element {
        lhs.append(contentsOf: rhs)
    }
}
