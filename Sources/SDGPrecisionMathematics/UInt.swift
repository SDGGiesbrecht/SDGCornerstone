/*
 UInt.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGMathematics

extension UIntFamily {

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
    let (simpleSum, overflowed) = self.addingReportingOverflow(addend)
    self = simpleSum
    if overflowed {
      carrying += (1 as Self)
    }
  }

  // MARK: - Subtraction

  internal mutating func subtract(_ subtrahend: Self, borrowingIn borrowing: inout Self) {
    let (simpleDifference, overflowed) = self.subtractingReportingOverflow(subtrahend)
    self = simpleDifference
    if overflowed {
      borrowing += (1 as Self)
    }
  }

  // MARK: - Multiplication

  private init(half: Half, at index: Half) {
    self = 0
    halves[index] = half
  }

  internal static func multiply(_ multiplicand: Self, with multiplier: Self) -> (
    product: Self, carried: Self
  ) {

    func multiplyHalf(_ multiplicand: Half, with multiplier: Half) -> (product: Self, carried: Self)
    {

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

        let halfResult = multiplyHalf(
          multiplicand.halves[multiplicandIndex],
          with: multiplier.halves[multiplierIndex]
        )

        let productIndex = multiplicandIndex + multiplierIndex
        add(half: halfResult.product, at: productIndex)

        if halfResult.carried ≠ 0 {
          add(half: halfResult.carried, at: productIndex + (1 as Self))
        }
      }
    }

    return (product: product, carried: carried)
  }
}
