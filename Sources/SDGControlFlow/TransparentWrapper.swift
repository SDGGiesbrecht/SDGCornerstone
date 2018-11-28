/*
 TransparentWrapper.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A wrapper which should be transparent when logging or displaying in a playground.
public protocol TransparentWrapper : CustomDebugStringConvertible, CustomPlaygroundDisplayConvertible, CustomStringConvertible {

    // @documentation(SDGCornerstone.TransparentWrapper.wrapped)
    /// The wrapped instance.
    var wrappedInstance: Any { get }
}

extension TransparentWrapper {

    // MARK: - CustomDebugStringConvertible

    // #documentation(SDGCornerstone.CustomDebugStringConvertible.debugDescription)
    /// A textual representation of this instance, suitable for debugging.
    @inlinable public var debugDescription: String {
        return String(reflecting: wrappedInstance)
    }

    // MARK: - CustomPlaygroundDisplayConvertible

    // #documentation(SDGCornerstone.CustomPlaygroundDisplayConvertible.playgroundDescription)
    /// Returns the custom playground description for this instance.
    @inlinable public var playgroundDescription: Any {
        return wrappedInstance
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    @inlinable public var description: String {
        return String(describing: wrappedInstance)
    }
}
