/*
 Addable.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics

extension Addable where Self : Pattern {

    @inlinable public static func + (precedingValue: Self, followingValue: Self) -> Self {
        // Disambiguate Addable vs Pattern
        return nonmutatingVariant(of: +=, on: precedingValue, with: followingValue)
    }
}

extension Addable where Self : RangeReplaceableCollection, Self : Pattern {

    @inlinable public static func + (precedingValue: Self, followingValue: Self) -> Self {
        // Disambiguate Addable vs RangeReplaceableCollection vs Pattern
        return nonmutatingVariant(of: +=, on: precedingValue, with: followingValue)
    }
}
