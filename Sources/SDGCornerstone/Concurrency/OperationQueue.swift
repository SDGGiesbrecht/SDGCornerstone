/*
 OperationQueue.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

extension OperationQueue {

    // MARK: - Initialization

    /// Creates an operation queue.
    ///
    /// - Parameters:
    ///     - name: A label for the queue.
    ///     - serial: Whether or not the queue should be serial.
    public convenience init(label: StrictString, serial: Bool) {
        self.init()
        self.name = String(label)
        if serial {
            maxConcurrentOperationCount = 1
        } else {
            maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
        }
    }

    // MARK: - Properties

    /// `true` if the queue is serial, otherwise `false`.
    public var isSerial: Bool {
        return maxConcurrentOperationCount == 1
    }

    // MARK: - Usage

    /// Causes the queue to start executing the specified task.
    public func start(_ task: @escaping () -> Void) {
        addOperation(BlockOperation(block: task))
    }

    /// Causes the queue to start *and finish* executing the specified task before returning.
    ///
    /// - Note: This is safe for a thread to call on itself.
    public func finish(_ task: @escaping () -> Void) {
        if executing(in: self) { // NECESSARY, otherwise it blocks the thread.
            task()
        } else {
            addOperations([BlockOperation(block: task)], waitUntilFinished: true)
        }
    }
}
