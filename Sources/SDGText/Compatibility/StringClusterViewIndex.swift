/*
 StringClusterViewIndex.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow

extension String/*.ClusterView*/.Index {

    // MARK: - Conversions

    /// Returns the position in the given view of scalars that corresponds exactly to this index.
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
}
