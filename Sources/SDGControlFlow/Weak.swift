/*
 Weak.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A weak reference to a class instance.
public struct Weak<Pointee : AnyObject> : TransparentWrapper {

    // MARK: - Initialization

    /// Creates a reference to a class instance.
    @inlinable public init(_ pointee: Pointee?) {
        self.pointee = pointee
    }

    // MARK: - Properties

    /// The pointee.
    public weak var pointee: Pointee?

    // MARK: - TransparentWrapper

    // #documentation(SDGCornerstone.TransparentWrapper.wrapped)
    /// The wrapped instance.
    @inlinable public var wrappedInstance: Any {
        return pointee as Any
    }
}
