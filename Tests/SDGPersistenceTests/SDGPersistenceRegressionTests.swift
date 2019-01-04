/*
 SDGPersistenceRegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGPersistence
import SDGXCTestUtilities

class SDGPersistenceRegressionTests : TestCase {

    func testCachePermissions() {
        // Untracked

        defer { FileManager.default.delete(.cache) }

        let file = "File"
        let url = FileManager.default.url(in: .cache, at: "File.txt")

        do {
            try file.save(to: url)
            XCTAssertEqual(try? String(from: url), file)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testPercentEncodingIsNotDoubled() {
        // Untracked

        var url = FileManager.default.url(in: .temporary, at: "A Folder")
        url.appendPathComponent("A File")
        XCTAssert(url.absoluteString.hasSuffix("A%20Folder/A%20File"))
        XCTAssert(url.path.hasSuffix("A Folder/A File"))
    }
}
