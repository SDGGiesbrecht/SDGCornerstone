/*
 StringScalarViewIndex.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension String.ScalarView.Index {

    // MARK: - Conversions

    /// Returns the position of the cluster that contains this index.
    @inlinable public func cluster(in clusters: String.ClusterView) -> String.ClusterView.Index {
        let string = String(clusters)

        var copy = self
        var position = samePosition(in: string)

        while position == nil {
            copy = string.unicodeScalars.index(before: copy)
            position = copy.samePosition(in: string)
        }

        guard let result = copy.samePosition(in: string) else {
            _unreachable()
        }
        return result
    }

    /// Returns the position in the given view of lines that corresponds exactly to this index.
    @inlinable public func samePosition(in lines: LineView<String>) -> LineView<String>.Index? {
        let line = self.line(in: lines)
        guard let start = line.start else {
            // End index
            return line
        }
        guard start == self else {
            // In the middle.
            return nil
        }
        return line
    }

    /// Returns the position of the line that contains this index.
    @inlinable public func line(in lines: LineView<String>) -> LineView<String>.Index {
        return lines.line(for: self)
    }
}
