/*
 Line.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A line in a string.
public struct Line<Base : StringFamilyCore> {

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
}
