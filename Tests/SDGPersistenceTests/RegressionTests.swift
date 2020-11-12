/*
 RegressionTests.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGPersistence

import XCTest

import SDGXCTestUtilities

class RegressionTests: TestCase {

  func testAndroidTemporaryDirectory() throws {
    // Untracked

    try FileManager.default.withTemporaryDirectory(appropriateFor: nil) { temporary in
      try "File".save(to: temporary.appendingPathComponent("File.txt"))
    }
  }

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

  func testDirectoryDetection() throws {
    // Untracked

    try FileManager.default.withTemporaryDirectory(appropriateFor: nil) { temporary in
      let directory = temporary.appendingPathComponent("Directory", isDirectory: false)
      let fileName = "File.txt"
      let contents = directory.appendingPathComponent(fileName)
      try "File".save(to: contents)
      XCTAssert(
        try FileManager.default.deepFileEnumeration(in: directory).contains(where: {
          $0.lastPathComponent == fileName
        })
      )
    }
  }

  func testPercentEncodingIsNotDoubled() {
    // Untracked

    FileManager.default.withTemporaryDirectory(appropriateFor: nil) { directory in
      var url = directory.appendingPathComponent("A Folder")
      url.appendPathComponent("A File")
      XCTAssert(url.absoluteString.hasSuffix("A%20Folder/A%20File"))
      XCTAssert(url.path.hasSuffix("A Folder/A File"))
    }
  }

  func testRemoteURLs() throws {
    // Untracked

    do {
      _ = try String(from: URL(string: "http://example.com/some/path")!)
    } catch {
      // Error is espected; hanging due to infinite recursion is not.
    }
  }
}
