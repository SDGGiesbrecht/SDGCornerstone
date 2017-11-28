/*
 RunLoop.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/SDGCornerstone

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

extension RunLoop {

    // MARK: - Running the Loop

    /// A class that manages a run loop.
    public class Driver {}

    // [_Example 1: Run Loop Usage_]
    /// Runs the run loop for the lifetime of the driver provided to `holdDriver`.
    ///
    /// For example:
    ///
    /// ```swift
    /// var driver: RunLoop.Driver?
    /// background.start() {
    ///     RunLoop.current.runForDriver() { driver = $0 }
    /// }
    /// // The background run loop is now running.
    ///
    /// driver = nil
    /// // The background run loop has now stopped.
    /// ```
    ///
    /// - Warning: Giving the run loop (or any of its timers, ports, etc.) a strong reference to the driver will create a retain cycle.
    ///
    /// - Parameters:
    ///     - holdDriver: A closer that takes ownershipe of the driver by creating a strong reference to it somewhere with the desired lifetime.
    ///     - driver: The driver that runs the loop. As soon as ARC deallocates this driver, the run loop will stop.
    public func runForDriver(_ holdDriver: (_ driver: Driver) -> Void) {
        var driver: Driver? = Driver()
        weak var weakDriver = driver
        holdDriver(driver!)
        driver = nil

        while weakDriver ≠ nil {
            run(until: Date(timeIntervalSinceNow: 1))
        }
    }

    /// Runs the run loop for the lifetime of the driver provided to `holdDriver` and executes `cleanUp` when the run loop stops.
    ///
    /// - SeeAlso: `runForDriver(_:)`
    public func runForDriver(_ holdDriver: (_ driver: Driver) -> Void, withCleanUp cleanUp: () -> Void) {
        runForDriver(holdDriver)
        cleanUp()
    }
}
