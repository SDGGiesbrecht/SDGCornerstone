/*
 FunctionAnalysis.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2016–2023 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

// MARK: - Function Analysis

// Local Extremes

@inlinable internal func findLocalExtreme<I: OneDimensionalPoint, O>(
  near location: I,
  within bounds: CountableClosedRange<I>?,
  inFunction function: (I) -> O,
  isCloser: (O, O) -> Bool
) -> I where I.Vector: IntegerProtocol {
  var location = location

  _assert(
    bounds == nil ∨ bounds!.contains(location),
    { (localization: _APILocalization) -> String in  // @exempt(from: tests)
      switch localization {  // @exempt(from: tests)
      case .englishCanada:
        return "Location out of bounds. \(location) ∉ \(String(describing: bounds))"
      }
    }
  )

  while location ≠ bounds?.upperBound ∧ isCloser(function(location.successor()), function(location))
  {
    location = location.successor()
  }

  while location ≠ bounds?.lowerBound
    ∧ isCloser(function(location.predecessor()), function(location))
  {
    location = location.predecessor()
  }

  return location
}

// #example(1, findLocalMaximumUndefined1) #example(2, findLocalMaximumUndefined2) #example(3, findLocalMaximumPreconditionViolation)
/// Returns the input (*x*) corresponding to the local maximum output (*y*) near `location`.
///
/// This function automates a guess‐and‐check strategy and is useful for inverting otherwise one‐way functions. See the related function `findLocalMaximum(near:bounds:inFunction:)` for an example.
///
/// - Warning: Behaviour is undefined when:
///   - `location` is at a local minimum. For example:
///       ```swift
///       // This is undefined:
///       let maximum = findLocalMaximum(near: 0) { $0 ∈ −10...10 ? $0 ↑ 2 : −($0 ↑ 2) }
///       ```
///   - two or more adjascent inputs share the maximum output. For example:
///       ```swift
///       // This is undefined:
///       let maximum = findLocalMaximum(near: 0) { $0 ∈ −10...10 ? 1 : −(|$0|) }
///       ```
///
/// - Precondition: If `bounds ≠ nil`, a local maximum must be known to exist, otherwise execution will get stuck in an infinite loop. For example:
///   ```swift
///   // Never do this:
///   _ = findLocalMaximum(near: 0, inFunction: { $0 })
///   ```
///
/// - Parameters:
///   - location: A location (*x*) where the slope approaches the searched‐for local maximum.
///   - bounds: An optional domain (for *x*) to stay within.
///   - function: The function to analyze.
/// - Returns: The input (*x*) that results in the local maximum (*y*).
@inlinable public func findLocalMaximum<I: OneDimensionalPoint, O: Comparable>(
  near location: I,
  within bounds: CountableClosedRange<I>? = nil,
  inFunction function: (_ input: I) -> O
) -> I where I.Vector: IntegerProtocol {
  return findLocalExtreme(
    near: location,
    within: bounds,
    inFunction: function,
    isCloser: { $0 ≥ $1 }
  )
}

// #example(1, findLocalMinimum) #example(2, findLocalMinimumUndefined1) #example(3, findLocalMinimumUndefined2) #example(4, findLocalMinimumPreconditionViolation)
/// Returns the input (*x*) corresponding to the local minimum output (*y*) near `location`.
///
/// This function automates a guess‐and‐check strategy and is useful for inverting otherwise one‐way functions. For example, finding the approximate square root of 120 can be done using only simpler arithmetic like this:
///
/// ```swift
/// let approximateSquareRootOf120 = findLocalMinimum(near: 10) { (guess: Int) -> Int in
///
///   // Find the square of the guess.
///   let square = guess × guess
///
///   // Determine its proximity to 120.
///   return |(square − 120)|
/// }
///
/// // First iteration (determined by “near: 10”):
/// // 10 → 20
///
/// // Second iteration:
/// // 11 → 1
/// // Decreasing, so continue.
///
/// // Third iteration:
/// // 12 → 24
/// // No longer decreasing, so stop. 1 was the local minimum.
///
/// XCTAssertEqual(approximateSquareRootOf120, 11)
/// ```
///
/// - Warning: Behaviour is undefined when:
///   - `location` is at a local maximum. For example:
///       ```swift
///       // This is undefined:
///       let minimum = findLocalMinimum(near: 0) { $0 ∈ −10...10 ? −($0 ↑ 2) : $0 ↑ 2 }
///       ```
///   - two or more adjascent inputs share the minimum output. For example:
///       ```swift
///       // This is undefined:
///       let minimum = findLocalMinimum(near: 0) { $0 ∈ −10...10 ? −1 : |$0| }
///       ```
///
/// - Precondition: If `bounds ≠ nil`, a local minimum must be known to exist, otherwise execution will get stuck in an infinite loop. For example:
///   ```swift
///   // Never do this:
///   _ = findLocalMinimum(near: 0, inFunction: { $0 })
///   ```
///
/// - Parameters:
///   - location: A location (*x*) where the slope approaches the searched‐for local minimum.
///   - bounds: An optional domain (for *x*) to stay within.
///   - function: The function to analyze.
/// - Returns: The input (*x*) that results in the local minimum (*y*).
@inlinable public func findLocalMinimum<I: OneDimensionalPoint, O: Comparable>(
  near location: I,
  within bounds: CountableClosedRange<I>? = nil,
  inFunction function: (_ input: I) -> O
) -> I where I.Vector: IntegerProtocol {
  return findLocalExtreme(
    near: location,
    within: bounds,
    inFunction: function,
    isCloser: { $0 ≤ $1 }
  )
}
