/*
 ExternalProcessError.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2017–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(iOS) || os(watchOS) || os(tvOS))

import SDGText
import SDGLocalization

extension ExternalProcess {

    /// An error related to running an external process.
    public enum Error : PresentableError {

        /// Foundation encountered an error.
        case foundationError(Swift.Error)

        /// The external process exited with an error.
        case processError(code: Int, output: String)

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
            switch self {
            case .foundationError(let error):
                return StrictString(error.localizedDescription)
            case .processError(code: _, output: let output):
                return StrictString(output)
            }
        }
    }
}

#endif
