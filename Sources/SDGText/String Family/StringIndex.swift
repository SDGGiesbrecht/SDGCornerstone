/*
 StringIndex.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#warning("Is this necessary?")
import SDGControlFlow

extension String.Index {

    // MARK: - Conversions

    /// Returns the position in the given view of scalars that corresponds exactly to this index.
    ///
    /// - Precondition: The index must be a valid cluster index, such as those received from any `String` or `ClusterView` API. Since Swift 4 it has been possible for the indices of other string views (`ScalarView`, `UTF8View`, `UTF16View`) to masquerade as cluster indices by way of some unfortunate typealiases, despite being completely invalid. This method traps upon receiving such an invalid index.
    ///
    /// - Parameters:
    ///     - scalars: The scalar view of the string the range refers to.
    @inlinable public func samePosition(in scalars: String.ScalarView) -> String.ScalarView.Index {
        guard let result = samePosition(in: scalars) as String.ScalarView.Index? else {
            _preconditionFailure({ (localization: _APILocalization) -> String in // @exempt(from: tests)
                switch localization {
                case .englishCanada: // @exempt(from: tests)
                    return "Not a cluster boundary: \(self)"
                }
            })
        }
        return result
    }

    /// Returns the position in the given view of scalars that corresponds exactly to this index.
    ///
    /// - Parameters:
    ///     - scalars: The scalar view of the string the range refers to.
    @inlinable public func samePosition(in scalars: StrictString) -> StrictString.Index {
        return samePosition(in: String(StrictString(scalars)).scalars)
    }

    /// Returns the position of the cluster that contains this index.
    ///
    /// - Parameters:
    ///     - clusters: The cluster view of the string the range refers to.
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
    ///
    /// - Parameters:
    ///     - lines: The line view of the string the range refers to.
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
    ///
    /// - Parameters:
    ///     - lines: The line view of the string the range refers to.
    @inlinable public func line(in lines: LineView<String>) -> LineView<String>.Index {
        return lines.line(for: self)
    }
}
