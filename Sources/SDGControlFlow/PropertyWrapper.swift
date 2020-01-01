/*
 PropertyWrapper.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A type usable as a property wrapper.
///
/// - Note: The protocol exists mostly for documentation purposes, since conforming types inherit its documentation comments. It has no means of enforcing the presence of a `@propertyWrapper` attribute.
public protocol PropertyWrapper {

  /// The wrapped type.
  associatedtype Wrapped

  /// The wrapped value.
  var wrappedValue: Wrapped { get }
}
