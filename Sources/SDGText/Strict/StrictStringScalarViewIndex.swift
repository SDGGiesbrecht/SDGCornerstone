/*
 StrictStringScalarViewIndex.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension String.UnicodeScalarView.Index {

    // MARK: - Conversions

    /// Returns the position in the given view of clusters that corresponds exactly to this index.
    ///
    /// - Parameters:
    ///     - clusters: The cluster view of the string the range refers to.
    @inlinable public func samePosition(in clusters: StrictString.ClusterView) -> StrictString.ClusterView.Index? {
        return samePosition(in: String(StrictString(clusters)))
    }

    /// Returns the position of the cluster that contains this index.
    ///
    /// - Parameters:
    ///     - clusters: The cluster view of the string the range refers to.
    @inlinable public func cluster(in clusters: StrictString.ClusterView) -> StrictString.ClusterView.Index {
        return cluster(in: String(StrictString(clusters)).clusters)
    }

    /// Returns the position in the given view of lines that corresponds exactly to this index.
    ///
    /// - Parameters:
    ///     - lines: The line view of the string the range refers to.
    @inlinable public func samePosition(in lines: LineView<StrictString>) -> LineView<StrictString>.Index? {
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
    ///
    /// - Parameters:
    ///     - lines: The line view of the string the range refers to.
    @inlinable public func line(in lines: LineView<StrictString>) -> LineView<StrictString>.Index {
        return lines.line(for: self)
    }
}
