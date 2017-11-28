/*
 String.ClusterView.Index.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension String/*.ClusterView*/.Index {

    // MARK: - Conversions

    /// Returns the position in the given view of scalars that corresponds exactly to this index.
    public func samePosition(in scalars: String.ScalarView) -> String.ScalarView.Index {
        guard let result = samePosition(in: scalars) as String.ScalarView.Index? else {
            unreachable()
        }
        return result
    }
}
