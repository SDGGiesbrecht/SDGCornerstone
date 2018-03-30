/*
 ExternalProcessError.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(iOS) || os(watchOS) || os(tvOS))
    // MARK: - #if !(os(iOS) || os(watchOS) || os(tvOS))

    extension ExternalProcess {

        /// A shell error.
        public struct Error : Swift.Error {

            // MARK: - Initialization

            internal init(code: Int, output: String) {
                self.code = code
                self.output = output
            }

            // MARK: - Properties

            /// The exit code.
            public let code: Int

            /// The output received.
            public let output: String
        }
    }

#endif
