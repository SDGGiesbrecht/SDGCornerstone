/*
 Sequence.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Sequence where Element: Hashable {

  /// Returns the statistical modes.
  ///
  /// - Returns: The statistical modes. This may be empty if the original sequence is empty.
  @inlinable public func statisticalModes() -> [Element] {
    var modes: [Element] = []
    var modeCount: Int = 0
    for (element, count) in countedSet() {
      if count > modeCount {
        modeCount = count
        modes = [element]
      } else if count == modeCount {
        modes.append(element)
      }
    }
    return modes
  }

  /// Returns the number of each type of element present in the sequence.
  @inlinable public func countedSet() -> [Element: Int] {
    var set: [Element: Int] = [:]
    for element in self {
      set[element, default: 0] += 1
    }
    return set
  }
}

extension Sequence where Element: GenericAdditiveArithmetic {

  /// Returns the sum of all values in the sequence.
  ///
  /// - Parameters:
  ///   - sequence: The sequence.
  @inlinable public static prefix func ∑ (sequence: Self) -> Element {
    var sum = Element.zero
    for element in sequence {
      sum += element
    }
    return sum
  }
}

extension Sequence where Element: WholeArithmetic {

  /// Returns the product of all values in the sequence.
  ///
  /// - Parameters:
  ///   - sequence: The sequence.
  @inlinable public static prefix func ∏ (sequence: Self) -> Element {
    var product: Element = 1
    for element in sequence {
      product ×= element
    }
    return product
  }
}

extension Sequence where Element: RationalArithmetic {

  /// Returns the arithmetic mean.
  ///
  /// - Returns: The arithmetic mean or `nil` if the collection is empty.
  @inlinable public func mean() -> Element? {
    var iterator = makeIterator()
    guard var average = iterator.next() else {
      return nil
    }
    var count: Element = 1
    while let element = iterator.next() {
      count += 1 as Element
      average += (element − average) ÷ count
    }
    return average
  }

  /// Returns the median.
  ///
  /// - Returns: The median or `nil` if the collection is empty.
  @inlinable public func median() -> Element? {
    let sorted = self.sorted()
    let count = sorted.count
    if count == 0 { return nil }

    let halfway = count.dividedAccordingToEuclid(by: 2)
    if count.isOdd {
      return sorted[sorted.index(sorted.startIndex, offsetBy: halfway)]
    } else {
      let upper = sorted.index(sorted.startIndex, offsetBy: halfway)
      let lower = sorted.index(before: upper)
      return [sorted[lower], sorted[upper]].mean()
    }
  }
}
