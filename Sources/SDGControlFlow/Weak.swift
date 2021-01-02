/*
 Weak.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2021 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A weak reference to a class instance.
@propertyWrapper
public struct Weak<Pointee: AnyObject>: ProjectingPropertyWrapper, TransparentWrapper {

  // MARK: - Initialization

  /// Creates a reference to a class instance.
  ///
  /// - Parameters:
  ///     - pointee: The pointee.
  public init(_ pointee: Pointee?) {
    self.pointee = pointee
  }

  /// Creates an empty reference.
  public init() {}

  // MARK: - Properties

  /// The pointee.
  public weak var pointee: Pointee?

  // MARK: - ProjectingPropertyWrapper

  public var projectedValue: Weak<Pointee> {
    get {
      return self
    }
    set {
      self = newValue
    }
  }

  // MARK: - PropertyWrapper

  public var wrappedValue: Pointee? {
    get {
      return pointee
    }
    set {
      pointee = newValue
    }
  }

  // MARK: - TransparentWrapper

  public var wrappedInstance: Any {
    return pointee as Any
  }
}
