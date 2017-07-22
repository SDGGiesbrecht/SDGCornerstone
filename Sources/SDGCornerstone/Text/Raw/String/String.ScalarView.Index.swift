/*
 String.ScalarView.Index.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension String.UnicodeScalarView.Index {

    // MARK: - Conversions

    /// Returns the position of the cluster that contains this index.
    public func cluster(in clusters: String.ClusterView) -> String.ClusterView.Index {
        let string = String(clusters)

        var copy = self
        var position = samePosition(in: string)

        while position == nil {
            copy = string.unicodeScalars.index(before: copy)
            position = copy.samePosition(in: string)
        }

        guard let result = copy.samePosition(in: string) else {
            unreachable()
        }
        return result
    }

    /// Returns the position in the given view of lines that corresponds exactly to this index.
    public func samePosition(in lines: LineView<String>) -> LineView<String>.Index? {
        var result = lines.startIndex
        for match in String(lines).scalars.matches(for: LineView<String>.newlinePattern) {

            if self == match.range.lowerBound {
                return result
            } else if self > match.range.upperBound {
                result += 1
            } else {
                break
            }
        }
        return nil
    }

    /// Returns the position of the line that contains this index.
    public func line(in lines: LineView<String>) -> LineView<String>.Index {
        var result = lines.startIndex
        for match in String(lines).scalars.matches(for: LineView<String>.newlinePattern) {
            if self ≥ match.range.upperBound {
                result += 1
            } else {
                break
            }
        }
        return result
    }
}
