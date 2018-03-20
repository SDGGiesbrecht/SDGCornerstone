/*
 NonmutatingVariants.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// MARK: - Methods

// [_Example 1: Nonmutating Variant_]
/// Implements a nonmutating function based on its mutating counterpart.
///
/// ```swift
/// extension Array where Element : Comparable {
///     func sorted() -> Array {
///         return nonmutatingVariant(of: Array.sort, on: self)
///     }
///     func appending(_ appendix: Array) -> Array {
///         return nonmutatingVariant(of: Array.append, on: self, with: appendix)
///     }
///     static func + (a: Array, b: Array) -> Array {
///         return nonmutatingVariant(of: +=, on: a, with: b)
///     }
/// }
/// ```
///
/// - Parameters:
///     - mutation: The mutating counterpart.
///     - self: The instance.
@_inlineable public func nonmutatingVariant<T>(of mutation: (inout T) -> () -> Void, on `self`: T) -> T {
    var copy = `self`
    mutation(&copy)()
    return copy
}

// [_Example 1: Nonmutating Variant_]
/// Implements a nonmutating function based on its mutating counterpart.
///
/// ```swift
/// extension Array where Element : Comparable {
///     func sorted() -> Array {
///         return nonmutatingVariant(of: Array.sort, on: self)
///     }
///     func appending(_ appendix: Array) -> Array {
///         return nonmutatingVariant(of: Array.append, on: self, with: appendix)
///     }
///     static func + (a: Array, b: Array) -> Array {
///         return nonmutatingVariant(of: +=, on: a, with: b)
///     }
/// }
/// ```
///
/// - Parameters:
///     - mutation: The mutating counterpart.
///     - self: The instance.
///     - argument: An argument to pass to the mutating counterpart.
@_inlineable public func nonmutatingVariant<T, A>(of mutation: (inout T) -> (A) -> Void, on `self`: T, with argument: A) -> T {
    var copy = `self`
    mutation(&copy)(argument)
    return copy
}

// [_Example 1: Nonmutating Variant_]
/// Implements a nonmutating function based on its mutating counterpart.
///
/// ```swift
/// extension Array where Element : Comparable {
///     func sorted() -> Array {
///         return nonmutatingVariant(of: Array.sort, on: self)
///     }
///     func appending(_ appendix: Array) -> Array {
///         return nonmutatingVariant(of: Array.append, on: self, with: appendix)
///     }
///     static func + (a: Array, b: Array) -> Array {
///         return nonmutatingVariant(of: +=, on: a, with: b)
///     }
/// }
/// ```
///
/// - Parameters:
///     - mutation: The mutating counterpart.
///     - self: The instance.
///     - argument: An argument to pass to the mutating counterpart.
@_inlineable public func nonmutatingVariant<T, A, B>(of mutation: (inout T) -> (A, B) -> Void, on `self`: T, with arguments: (A, B)) -> T {
    var copy = `self`
    mutation(&copy)(arguments.0, arguments.1)
    return copy
}

// [_Example 1: Nonmutating Variant_]
/// Implements a nonmutating function based on its mutating counterpart.
///
/// ```swift
/// extension Array where Element : Comparable {
///     func sorted() -> Array {
///         return nonmutatingVariant(of: Array.sort, on: self)
///     }
///     func appending(_ appendix: Array) -> Array {
///         return nonmutatingVariant(of: Array.append, on: self, with: appendix)
///     }
///     static func + (a: Array, b: Array) -> Array {
///         return nonmutatingVariant(of: +=, on: a, with: b)
///     }
/// }
/// ```
///
/// - Parameters:
///     - mutation: The mutating counterpart.
///     - self: The instance.
///     - argument: An argument to pass to the mutating counterpart.
@_inlineable public func nonmutatingVariant<T, A, B, C>(of mutation: (inout T) -> (A, B, C) -> Void, on `self`: T, with arguments: (A, B, C)) -> T {
    var copy = `self`
    mutation(&copy)(arguments.0, arguments.1, arguments.2)
    return copy
}

// MARK: - Operators

// [_Example 1: Nonmutating Variant_]
/// Implements a nonmutating function based on its mutating counterpart.
///
/// ```swift
/// extension Array where Element : Comparable {
///     func sorted() -> Array {
///         return nonmutatingVariant(of: Array.sort, on: self)
///     }
///     func appending(_ appendix: Array) -> Array {
///         return nonmutatingVariant(of: Array.append, on: self, with: appendix)
///     }
///     static func + (a: Array, b: Array) -> Array {
///         return nonmutatingVariant(of: +=, on: a, with: b)
///     }
/// }
/// ```
///
/// - Parameters:
///     - mutation: The mutating counterpart.
///     - self: The instance.
///     - argument: An argument to pass to the mutating counterpart.
@_inlineable public func nonmutatingVariant<T, A>(of mutation: (inout T, A) throws -> Void, on `self`: T, with argument: A) rethrows -> T {
    var copy = `self`
    try mutation(&copy, argument)
    return copy
}

// [_Example 1: Nonmutating Variant_]
/// Implements a nonmutating function based on its mutating counterpart.
///
/// ```swift
/// extension Array where Element : Comparable {
///     func sorted() -> Array {
///         return nonmutatingVariant(of: Array.sort, on: self)
///     }
///     func appending(_ appendix: Array) -> Array {
///         return nonmutatingVariant(of: Array.append, on: self, with: appendix)
///     }
///     static func + (a: Array, b: Array) -> Array {
///         return nonmutatingVariant(of: +=, on: a, with: b)
///     }
/// }
/// ```
///
/// - Parameters:
///     - mutation: The mutating counterpart.
///     - self: The instance.
@_inlineable public func nonmutatingVariant<T>(of mutation: (inout T) throws -> Void, on `self`: T) rethrows -> T {
    return try nonmutatingVariant(of: { (x: inout T, _: Void) in try mutation(&x) }, on: `self`, with: ())
}
