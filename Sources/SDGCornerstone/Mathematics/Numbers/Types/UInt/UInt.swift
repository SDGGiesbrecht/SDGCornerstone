/*
 UInt.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type that represents a fixed‐length unsigned integer.
///
/// This protocol exists so that extensions to it can provide shared functionality for `UInt`, `UInt64`, `UInt32`, `UInt16` and `UInt8`.
public protocol UIntFamily : Addable, AdditiveArithmetic, BitwiseLogic, CustomPlaygroundQuickLookable, CustomReflectable, CVarArg, NumericAdditiveArithmetic, OneDimensionalPoint, PointProtocol, Subtractable, UnsignedInteger, WholeArithmetic, WholeNumberProtocol {

    /// Creates a value from an `Int`.
    init(_ value: Int)

    /// Returns the bits of `lhs` shifted leftward by `rhs`.
    static func << (lhs: Self, rhs: Self) -> Self

    /// Returns the bits of `lhs` shifted rightward by `rhs`.
    static func >> (lhs: Self, rhs: Self) -> Self
}

extension UInt : UIntFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}

extension UIntMax {

    // MARK: - WholeArithmetic

    // [_Inherit Documentation: SDGCornerstone.WholeArithmetic.init(randomInRange:fromRandomizer:)_]
    /// Creates a random value within a particular range using the specified randomizer.
    ///
    /// - Parameters:
    ///     - range: The allowed range for the random value.
    ///     - randomizer: The randomizer to use to generate the random value.
    public init(randomInRange range: ClosedRange<UIntMax>, fromRandomizer randomizer: Randomizer) {
        self = randomizer.randomNumber(inRange: range)
    }
}

extension UInt64 : UIntFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}

extension UInt32 : UIntFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}

extension UInt16 : UIntFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

}

extension UInt8 : UIntFamily {

    // MARK: - PointProtocol

    // [_Inherit Documentation: SDGCornerstone.PointProtocol.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

}

extension UIntFamily {

    // MARK: - Binary

    /// The value of self represented in binary as a collection of bits.
    public var binary: BinaryView<Self> {
        get {
            return BinaryView(self)
        }
        set {
            self = newValue.uInt
        }
    }

    // MARK: - Extensions for WholeNumber

    // MARK: - Subdigits

    private typealias Half = HalvesView<Self>.Element
    private typealias HalfIndex = HalvesView<Self>.Index
    internal var halves: HalvesView<Self> {
        get {
            return HalvesView(self)
        }
        set {
            self = newValue.uInt
        }
    }

    // MARK: - Addition

    internal mutating func add(_ addend: Self, carringIn carrying: inout Self) {
        let (simpleSum, overflowed) = Self.addWithOverflow(self, addend)
        self = simpleSum
        if overflowed {
            carrying += 1
        }
    }

    // MARK: - Subtraction

    internal mutating func subtract(_ subtrahend: Self, borrowingIn borrowing: inout Self) {
        let (simpleDifference, overflowed) = Self.subtractWithOverflow(self, subtrahend)
        self = simpleDifference
        if overflowed {
            borrowing += 1
        }
    }

    // MARK: - Multiplication

    private init(half: Half, at index: Half) {
        self = 0
        halves[index] = half
    }

    internal static func multiply(_ multiplicand: Self, with multiplier: Self) -> (product: Self, carried: Self) {

        func multiplyHalf(_ multiplicand: Half, with multiplier: Half) -> (product: Self, carried: Self) {

            let product = multiplicand × multiplier
            return (product: product.halves[0], carried: product.halves[1])
        }

        var product: Self = 0
        var carried: Self = 0
        func add(half: Half, at index: HalfIndex) {
            let count = HalfIndex(HalvesView<Self>.count)
            if index < count {
                product.add(Self(half: half, at: index), carringIn: &carried)
            } else {
                carried += Self(half: half, at: index − count)
            }
        }
        for multiplierIndex in multiplier.halves.indices {
            for multiplicandIndex in multiplicand.halves.indices {

                let halfResult = multiplyHalf(multiplicand.halves[multiplicandIndex], with: multiplier.halves[multiplierIndex])

                let productIndex = multiplicandIndex + multiplierIndex
                add(half: halfResult.product, at: productIndex)

                if halfResult.carried ≠ 0 {
                    add(half: halfResult.carried, at: productIndex + 1)
                }
            }
        }

        return (product: product, carried: carried)
    }

    // MARK: - BitwiseLogic

    // [_Inherit Documentation: SDGCornerstone.BitwiseLogic.bitwiseNot()_]
    /// Returns the bits not present in `self`.
    public func bitwiseNot() -> Self {
        return ~self
    }

    // [_Inherit Documentation: SDGCornerstone.BitwiseLogic.formBitwiseNot()_]
    /// Inverts the bits.
    public mutating func formBitwiseNot() {
        self = bitwiseNot()
    }

    // [_Inherit Documentation: SDGCornerstone.BitwiseLogic.bitwiseAnd(with:)_]
    /// Returns the bits present in both `self` and `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    public func bitwiseAnd(with other: Self) -> Self {
        return self & other
    }

    // [_Inherit Documentation: SDGCornerstone.BitwiseLogic.formBitwiseAnd(with:)_]
    /// Removes the bits not also present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    public mutating func formBitwiseAnd(with other: Self) {
        self = bitwiseAnd(with: other)
    }

    // [_Inherit Documentation: SDGCornerstone.BitwiseLogic.bitwiseOr(with:)_]
    /// Returns the bits present in either `self` or `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    public func bitwiseOr(with other: Self) -> Self {
        return self | other
    }

    // [_Inherit Documentation: SDGCornerstone.BitwiseLogic.formBitwiseOr(with:)_]
    /// Inserts the bits present in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    public mutating func formBitwiseOr(with other: Self) {
        self = bitwiseOr(with: other)
    }

    // [_Inherit Documentation: SDGCornerstone.BitwiseLogic.bitwiseExclusiveOr(with:)_]
    /// Returns the bits present only in `self` or only in `other`.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    public func bitwiseExclusiveOr(with other: Self) -> Self {
        return self ^ other
    }

    // [_Inherit Documentation: SDGCornerstone.BitwiseLogic.formBitwiseExclusiveOr(with:)_]
    /// Inserts the bits present in `other` and removes the bits present in both.
    ///
    /// - Parameters:
    ///     - other: The other bits.
    public mutating func formBitwiseExclusiveOr(with other: Self) {
        self = bitwiseExclusiveOr(with: other)
    }
}
