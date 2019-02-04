/*
 TransparentWrapper.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A wrapper which should be transparent when logging or displaying in a playground.
public protocol TransparentWrapper : CustomDebugStringConvertible, CustomPlaygroundDisplayConvertible, CustomStringConvertible {

    /// The wrapped instance.
    var wrappedInstance: Any { get }
}

extension TransparentWrapper {

    // MARK: - CustomDebugStringConvertible

    @inlinable public var debugDescription: String {
        return String(reflecting: wrappedInstance)
    }

    // MARK: - CustomPlaygroundDisplayConvertible

    @inlinable public var playgroundDescription: Any {
        return wrappedInstance
    }

    // MARK: - CustomStringConvertible

    @inlinable public var description: String {
        return String(describing: wrappedInstance)
    }
}
