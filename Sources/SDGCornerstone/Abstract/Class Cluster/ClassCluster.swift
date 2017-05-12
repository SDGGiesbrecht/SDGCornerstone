/*
 ClassCluster.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2016–2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// MARK: - Class Clusters

/// Throws a precondition failure indicating that the primitive method in which it is called has not been overridden.
///
/// - Parameters:
///     - method: The method. (Provided by default.)
public func primitiveMethod(_ method: String = #function) -> Never {
    preconditionFailure("The primitive method “\(method)” has not been overridden.")
}
