/*
 Dictionary.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// [_Workaround: Should only conform to PropertyListValue when keys are `String` and values conform to `PropertyListValue`. Currently not constrainable. (Swift 3.1.0)_]
extension Dictionary : PropertyListValue {

    // MARK: - Mutation

    // [_Example 1: mutateValue(for:_:)_]
    /// Mutates the value for the specified key.
    ///
    /// ```swift
    /// func rollDie() -> Int {
    ///     return Int(randomInRange: 1 ... 6)
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
    public mutating func mutateValue(for key: Key, _ mutate: (_ previous: Value?) throws -> Value?) rethrows {
        self[key] = try mutate(self[key])
    }

    // MARK: - Merging

    /// Merges `other` into `self`, overwriting any duplicate keys.
    ///
    /// - Parameters:
    ///     - other: Another dictionary.
    public mutating func mergeByOverwriting(from other: [Key: Value]) {
        merge(other, uniquingKeysWith: { $1 })
    }

    /// Returns a dictionary formed by merging `other` into `self`, overwriting any duplicate keys.
    ///
    /// - Parameters:
    ///     - other: Another dictionary.
    public func mergedByOverwriting(from other: [Key: Value]) -> [Key: Value] {
        var result = self
        result.mergeByOverwriting(from: other)
        return result
    }

    // MARK: - Mapping

    /// Returns a dictionary formed by mapping the key‐value pairs according to `transform`.
    ///
    /// - Parameters:
    ///     - transform: A mapping closure.
    public func mapKeyValuePairs<K, V>(_ transform: (_ key: Key, _ value: Value) throws -> (key: K, value: V)) rethrows -> [K: V] {
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
    public func mapKeys<T>(_ transform: (Key) throws -> T) rethrows -> [T: Value] {
        return try mapKeyValuePairs() { (try transform($0), $1) }
    }
}

extension Dictionary where Value : Equatable {
    // MARK: - where Value : Equatable

    // [_Workaround: This can be refactored once conditional conformance is available. (Swift 3.1.0)_]

    // [_Inherit Documentation: SDGCornerstone.Equatable.≠_]
    /// Returns `true` if the two values are inequal.
    ///
    /// - Parameters:
    ///     - lhs: A value to compare.
    ///     - rhs: Another value to compare.
    ///
    /// - RecommendedOver: !=
    public static func ≠(lhs: Dictionary, rhs: Dictionary) -> Bool {
        return lhs != rhs
    }
}
