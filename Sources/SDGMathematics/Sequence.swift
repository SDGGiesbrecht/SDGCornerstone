/*
 Sequence.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Sequence where Element : AdditiveArithmetic {
    // MARK: - where Element : AdditiveArithmetic

    // [_Define Documentation: SDGCornerstone.Sequence.∑_]
    /// Returns the sum of all values in the sequence.
    @_inlineable public static prefix func ∑ (sequence: Self) -> Element {
        var sum = Element.additiveIdentity
        for element in sequence {
            sum += element
        }
        return sum
    }
}

extension Sequence where Element : WholeArithmetic {
    // MARK: - where Element : WholeArithmetic

    // [_Define Documentation: SDGCornerstone.Sequence.∏_]
    /// Returns the product of all values in the sequence.
    @_inlineable public static prefix func ∏ (sequence: Self) -> Element {
        var product: Element = 1
        for element in sequence {
            product ×= element
        }
        return product
    }
}
