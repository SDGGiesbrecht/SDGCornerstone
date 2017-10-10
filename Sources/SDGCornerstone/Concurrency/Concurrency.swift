/*
 Concurrency.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

// MARK: - Concurrency

/// The main queue.
public var foreground: OperationQueue {
    return OperationQueue.main
}

/// A general‐purpose background queue for use when execution order is unimportant.
public let background: OperationQueue = {
    return OperationQueue(label: UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
        switch localization {
        case .englishCanada:
            return "Background"
        }
    }).resolved(), serial: false)
}()

#if !os(Linux) && !LinuxDocs
    // [_Workaround: Linux cannot reliably get the current queue. (Swift 3.1.0)_]

/// Returns `true` if current execution is occurring in specified queue, otherwise returns `false`.
public func executing(in queue: OperationQueue) -> Bool {
    return OperationQueue.current == queue
}

/// Fails an assertion if the current execution is anywhere but the specified thread.
public func assert(in queue: OperationQueue, function: StaticString = #function, file: StaticString = #file, line: UInt = #line) {
    assert(executing(in: queue), UserFacingText({ (localization: APILocalization, _: Void) -> StrictString in
        func resolveName(foregroundName: StrictString) -> StrictString { // [_Exempt from Code Coverage_]
            return queue == foreground ? foregroundName : StrictString(queue.name ?? "\(queue)") // [_Exempt from Code Coverage_]
        }
        switch localization {
        case .englishCanada: // [_Exempt from Code Coverage_]
            return StrictString("\(function) was called from the wrong queue. Expected queue: \(resolveName(foregroundName: "Foreground"))")
        }
    }), file: file, line: line)
}

#endif
