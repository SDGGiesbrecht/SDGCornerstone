/*
 Line.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

/// A line in a string.
public struct Line<Base : StringFamily> : TextualPlaygroundDisplay {

    /// Creates a line.
    @_inlineable public init(line: Base, newline: Base) {
        self.line = line.scalars[line.scalars.bounds]
        self.newline = newline.scalars[newline.scalars.bounds]
    }

    /// Creates a line.
    @_inlineable public init(line: Base.ScalarView.SubSequence, newline: Base.ScalarView.SubSequence) {
        self.line = line
        self.newline = newline
    }

    // MARK: - Properties

    /// The contents of the line.
    public var line: Base.ScalarView.SubSequence
    /// The trailing newline character(s).
    public var newline: Base.ScalarView.SubSequence

    // MARK: - CustomStringConvertible

    // [_Inherit Documentation: SDGCornerstone.CustomStringConvertible.description_]
    /// A textual representation of the instance.
    @_inlineable public var description: String {
        return String(describing: Base(Base.ScalarView(line))) + newline.map({ $0.visibleRepresentation }).joined()
    }
}
