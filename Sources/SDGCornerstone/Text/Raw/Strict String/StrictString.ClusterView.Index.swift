/*
 StrictString.ClusterView.Index.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension String.CharacterView.Index {

    // MARK: - Conversions

    /// Returns the position in the given view of scalars that corresponds exactly to this index.
    public func samePosition(in scalars: StrictString) -> StrictString.Index {
        return samePosition(in: String(StrictString(scalars)).scalars)
    }

    /// Returns the position in the given view of lines that corresponds exactly to this index.
    public func samePosition(in lines: LineView<StrictString>) -> LineView<StrictString>.Index? {
        return samePosition(in: StrictString(lines).scalars).samePosition(in: lines)
    }

    /// Returns the position of the line that contains this index.
    public func line(in lines: LineView<StrictString>) -> LineView<StrictString>.Index {
        return samePosition(in: StrictString(lines).scalars).line(in: lines)
    }
}
