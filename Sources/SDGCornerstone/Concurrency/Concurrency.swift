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
    return OperationQueue(label: UserFacingText({ (localization: APILocalization, _: Void) in
        switch localization {
        case .canadianEnglish:
            return "Background"
        }
    }), serial: false)
}()

/// Returns `true` if current execution is occurring in specified queue, otherwise returns `false`.
public func executing(in queue: OperationQueue) -> Bool {
    return OperationQueue.current == queue
}

/// Waits for the condition to evaluate to true before returning.
///
/// - Warning: Using this in the foreground of a GUI application will cause the application to become unresponsive.
///
/// - Parameters:
///     - condition: A closure that checks for the awaited condition.
///     - checkInterval: The interval to wait between checks. (Can be left out.)
public func wait(until condition: @autoclosure () -> Bool, checkInterval: TimeInterval = 1) {
    while ¬condition() {
        Thread.sleep(forTimeInterval: checkInterval)
    }
}
