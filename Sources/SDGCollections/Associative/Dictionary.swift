/*
 Dictionary.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension Dictionary {

    // MARK: - Mutation

    // #example(1, mutateValue)
    /// Mutates the value for the specified key.
    ///
    /// ```swift
    /// func rollDie() -> Int {
    ///     return Int.random(in: 1 ... 6)
    /// }
    ///
    /// var frequencies = [Int: Int]()
    /// for _ in 1 ... 100 {
    ///     frequencies.mutateValue(for: rollDie()) { ($0 ?? 0) + 1 }
    /// }
    /// print(frequencies.keys.sorted().map({ "\($0.inDigits()): \(frequencies[$0]!.inDigits())" }).joined(separator: "\n"))
    /// // Prints, for example:
    /// //
    /// // 1: 21
    /// // 2: 8
    /// // 3: 29
    /// // 4: 12
    /// // 5: 20
    /// // 6: 10
    ///
    /// // In this example, the die is rolled 100 times, and each time the tally for the outcome is incremented. After the for loop, the dictionary contains the frequencies (values) for each outcome (keys).
    /// ```
    ///
    /// - Parameters:
    ///     - key: The key whose value should change.
    ///     - mutate: A mutating closure.
    ///     - previous: The previous value or `nil` if the dictionary does not contain the specified key.
    @inlinable public mutating func mutateValue(for key: Key, _ mutate: (_ previous: Value?) throws -> Value?) rethrows {
        self[key] = try mutate(self[key])
    }

    // MARK: - Merging

    /// Merges `other` into `self`, overwriting any duplicate keys.
    ///
    /// - Parameters:
    ///     - other: Another dictionary.
    @inlinable public mutating func mergeByOverwriting(from other: [Key: Value]) {
        merge(other, uniquingKeysWith: { $1 })
    }

    /// Returns a dictionary formed by merging `other` into `self`, overwriting any duplicate keys.
    ///
    /// - Parameters:
    ///     - other: Another dictionary.
    @inlinable public func mergedByOverwriting(from other: [Key: Value]) -> [Key: Value] {
        return nonmutatingVariant(of: { $0.mergeByOverwriting(from: $1) }, on: self, with: other)
    }

    // MARK: - Mapping

    /// Returns a dictionary formed by mapping the key‐value pairs according to `transform`.
    ///
    /// - Parameters:
    ///     - transform: A mapping closure.
    @inlinable public func mapKeyValuePairs<K, V>(_ transform: (_ key: Key, _ value: Value) throws -> (key: K, value: V)) rethrows -> [K: V] {
        var result = [K: V]()
        for (key, value) in self {
            let mapped = try transform(key, value)
            result[mapped.key] = mapped.value
        }
        return result
    }

    /// Returns a dictionary created by mapping the keys according to `transform`.
    ///
    /// - Parameters:
    ///     - transform: A mapping closure.
    @inlinable public func mapKeys<T>(_ transform: (Key) throws -> T) rethrows -> [T: Value] {
        return try mapKeyValuePairs { (try transform($0), $1) }
    }
}
