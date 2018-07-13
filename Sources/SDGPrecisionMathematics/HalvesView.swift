/*
 HalvesView.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGBinaryData
import SDGCollections
import SDGLocalization
import SDGCornerstoneLocalizations

internal struct HalvesView<UIntValue : UIntFamily> : BidirectionalCollection, Collection, MutableCollection, RandomAccessCollection {

    // MARK: - Initialization

    internal init(_ uInt: UIntValue) {
        self.uInt = uInt
    }

    // MARK: - Static Properties

    internal static var count: Int {
        return 2
    }

    // MARK: - Properties

    internal var uInt: UIntValue

    private typealias BinarySize = UIntValue
    private var elementSize: BinarySize {
        let totalSize = BinarySize(BinaryView<UIntValue>.count)
        let elementCount = BinarySize(count)
        return totalSize.dividedAccordingToEuclid(by: elementCount)
    }

    private var elementMask: UIntValue {
        return (1 << elementSize) − 1
    }

    // MARK: - BidirectionalCollection

    @_specialize(exported: true, where UIntValue == UInt)
    @_specialize(exported: true, where UIntValue == UInt64)
    @_specialize(exported: true, where UIntValue == UInt32)
    @_specialize(exported: true, where UIntValue == UInt16)
    @_specialize(exported: true, where UIntValue == UInt8)
    internal func index(before i: Index) -> Index {
        return i − (1 as Index)
    }

    // MARK: - Collection

    internal typealias Element = UIntValue
    internal typealias Index = UIntValue

    internal let startIndex: Index = 0
    internal let endIndex: Index = Index(HalvesView.count)

    @_specialize(exported: true, where UIntValue == UInt)
    @_specialize(exported: true, where UIntValue == UInt64)
    @_specialize(exported: true, where UIntValue == UInt32)
    @_specialize(exported: true, where UIntValue == UInt16)
    @_specialize(exported: true, where UIntValue == UInt8)
    internal func index(after i: Index) -> Index {
        return i + (1 as Index)
    }

    internal func assertIndexExists(_ index: Index) {
        assert(index ∈ bounds, UserFacing<StrictString, APILocalization>({ localization in
            switch localization { // @exempt(from: tests)
            case .englishCanada:
                return "Index out of bounds."
            }
        }))
    }

    internal subscript(index: Index) -> Element {
        @_specialize(exported: true, where UIntValue == UInt)
        @_specialize(exported: true, where UIntValue == UInt64)
        @_specialize(exported: true, where UIntValue == UInt32)
        @_specialize(exported: true, where UIntValue == UInt16)
        @_specialize(exported: true, where UIntValue == UInt8)
        get {
            assertIndexExists(index)
            let offset = index × elementSize
            return uInt.bitwiseAnd(with: elementMask << offset) >> offset
        }
        @_specialize(exported: true, where UIntValue == UInt)
        @_specialize(exported: true, where UIntValue == UInt64)
        @_specialize(exported: true, where UIntValue == UInt32)
        @_specialize(exported: true, where UIntValue == UInt16)
        @_specialize(exported: true, where UIntValue == UInt8)
        set {
            assertIndexExists(index)
            let offset = index × elementSize
            let oldErased = uInt.bitwiseAnd(with: (elementMask << offset).bitwiseNot())
            uInt = oldErased.bitwiseOr(with: newValue << offset)
        }
    }

    // MARK: - RandomAccessCollection

    #if swift(>=4.1.50)
    // #workaround(Swift 4.1.2, This check can be removed in Swift 4.2)
    internal typealias Indices = DefaultIndices<HalvesView>
    #else
    // #workaround(Swift 4.1.2, This section can be removed in Swift 4.2)
    internal typealias Indices = DefaultRandomAccessIndices<HalvesView>
    #endif
}
