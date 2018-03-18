/*
 ShellError.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !(os(iOS) || os(watchOS) || os(tvOS))
    // MARK: - #if !(os(iOS) || os(watchOS) || os(tvOS))

    extension Shell {

        /// A shell error.
        public struct Error : Swift.Error {

            // MARK: - Initialization

            internal init(code: Int, description: String, output: String) {
                self.code = code
                self.description = description
                self.output = output
            }

            // MARK: - Properties

            /// The exit code.
            public let code: Int

            /// The output received by standard error.
            public let description: String

            /// The output received by standard out.
            public let output: String
        }
    }

#endif
