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
public protocol UIntFamily : Addable, AdditiveArithmetic, CustomPlaygroundQuickLookable, CustomReflectable, CVarArg, NumericAdditiveArithmetic, OneDimensionalPoint, PointType, Subtractable, UnsignedInteger, WholeArithmetic, WholeNumberType {

    /// Creates a value from an `Int`.
    init(_ value: Int)

    /// Returns the bits of `lhs` shifted leftward by `rhs`.
    static func << (lhs: Self, rhs: Self) -> Self

    /// Returns the bits of `lhs` shifted rightward by `rhs`.
    static func >> (lhs: Self, rhs: Self) -> Self
}

extension UInt : UIntFamily {

    // MARK: - PointType

    // [_Inherit Documentation: SDGCornerstone.PointType.Vector_]
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

    // MARK: - PointType

    // [_Inherit Documentation: SDGCornerstone.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}

extension UInt32 : UIntFamily {

    // MARK: - PointType

    // [_Inherit Documentation: SDGCornerstone.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride
}

extension UInt16 : UIntFamily {

    // MARK: - PointType

    // [_Inherit Documentation: SDGCornerstone.PointType.Vector_]
    /// The type to be used as a vector.
    public typealias Vector = Stride

}

extension UInt8 : UIntFamily {

    // MARK: - PointType

    // [_Inherit Documentation: SDGCornerstone.PointType.Vector_]
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
}
