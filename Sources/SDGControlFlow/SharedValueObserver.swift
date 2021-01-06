/*
 SharedValueObserver.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// An observer of a shared value.
public protocol SharedValueObserver: AnyObject {

  /// Called when a value changes.
  ///
  /// - Parameters:
  ///     - identifier: The identifier that was specified when the observer was registered. This can be used to differentiate between several values watched by the same observer.
  ///
  /// - SeeAlso: `register(observer:identifier:)`
  func valueChanged(for identifier: String)
}
