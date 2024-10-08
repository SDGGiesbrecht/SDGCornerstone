/*
 NonmutatingVariants.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #example(1, nonmutatingVariant)
/// Implements a nonmutating function based on its mutating counterpart.
///
/// ```swift
/// extension Array where Element: Comparable {
///
///   func sorted() -> Array {
///     return nonmutatingVariant(of: { $0.sort() }, on: self)
///   }
///   func appending(_ appendix: Array) -> Array {
///     return nonmutatingVariant(of: { $0.append(contentsOf: $1) }, on: self, with: appendix)
///   }
///   static func + (a: Array, b: Array) -> Array {
///     return nonmutatingVariant(of: +=, on: a, with: b)
///   }
/// }
/// ```
///
/// - Parameters:
///   - mutation: The mutating counterpart.
///   - theInstance: The starting instance.
@inlinable public func nonmutatingVariant<T>(
  of mutation: (_ anInstance: inout T) throws -> Void,
  on theInstance: T
) rethrows -> T {
  var copy = theInstance
  try mutation(&copy)
  return copy
}

// #example(1, nonmutatingVariant)
/// Implements a nonmutating function based on its mutating counterpart.
///
/// ```swift
/// extension Array where Element: Comparable {
///
///   func sorted() -> Array {
///     return nonmutatingVariant(of: { $0.sort() }, on: self)
///   }
///   func appending(_ appendix: Array) -> Array {
///     return nonmutatingVariant(of: { $0.append(contentsOf: $1) }, on: self, with: appendix)
///   }
///   static func + (a: Array, b: Array) -> Array {
///     return nonmutatingVariant(of: +=, on: a, with: b)
///   }
/// }
/// ```
///
/// - Parameters:
///   - mutation: The mutating counterpart.
///   - theInstance: The starting instance.
///   - argument: An argument to pass to the mutating counterpart.
@inlinable public func nonmutatingVariant<T, A>(
  of mutation: (_ anInstance: inout T, _ mutationArgument: A) throws -> Void,
  on theInstance: T,
  with argument: A
) rethrows -> T {
  var copy = theInstance
  try mutation(&copy, argument)
  return copy
}

// #example(1, nonmutatingVariant)
/// Implements a nonmutating function based on its mutating counterpart.
///
/// ```swift
/// extension Array where Element: Comparable {
///
///   func sorted() -> Array {
///     return nonmutatingVariant(of: { $0.sort() }, on: self)
///   }
///   func appending(_ appendix: Array) -> Array {
///     return nonmutatingVariant(of: { $0.append(contentsOf: $1) }, on: self, with: appendix)
///   }
///   static func + (a: Array, b: Array) -> Array {
///     return nonmutatingVariant(of: +=, on: a, with: b)
///   }
/// }
/// ```
///
/// - Parameters:
///   - mutation: The mutating counterpart.
///   - theInstance: The starting instance.
///   - arguments: Arguments to pass to the mutating counterpart.
@inlinable public func nonmutatingVariant<T, A, B>(
  of mutation: (
    _ anInstance: inout T,
    _ firstMutationArgument: A,
    _ secondMutationArgument: B
  ) throws -> Void,
  on theInstance: T,
  with arguments: (A, B)
) rethrows -> T {
  var copy = theInstance
  try mutation(&copy, arguments.0, arguments.1)
  return copy
}

// #example(1, nonmutatingVariant)
/// Implements a nonmutating function based on its mutating counterpart.
///
/// ```swift
/// extension Array where Element: Comparable {
///
///   func sorted() -> Array {
///     return nonmutatingVariant(of: { $0.sort() }, on: self)
///   }
///   func appending(_ appendix: Array) -> Array {
///     return nonmutatingVariant(of: { $0.append(contentsOf: $1) }, on: self, with: appendix)
///   }
///   static func + (a: Array, b: Array) -> Array {
///     return nonmutatingVariant(of: +=, on: a, with: b)
///   }
/// }
/// ```
///
/// - Parameters:
///   - mutation: The mutating counterpart.
///   - theInstance: The starting instance.
///   - arguments: Arguments to pass to the mutating counterpart.
@inlinable public func nonmutatingVariant<T, A, B, C>(
  of mutation: (
    _ anInstance: inout T,
    _ firstMutationArgument: A,
    _ secondMutationArgument: B,
    _ thirdMutationArgument: C
  ) throws -> Void,
  on theInstance: T,
  with arguments: (A, B, C)
) rethrows -> T {
  var copy = theInstance
  try mutation(&copy, arguments.0, arguments.1, arguments.2)
  return copy
}
