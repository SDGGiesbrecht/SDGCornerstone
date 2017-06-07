/*
 RunLoop.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

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

    /// ```swift
    /// ```
    ///
    /// - Warning: Giving the run loop (or any of its timers, ports, etc.) a strong reference to the driver will create a retain cycle.
    public func runForDriver(_ holdDriver: (_ driver: Driver) -> ()) {
        var driver: Driver? = Driver()
        weak var weakDriver = driver
        holdDriver(driver!)
        driver = nil

        while weakDriver ≠ nil {
            run(until: Date(timeIntervalSinceNow: 1))
        }
    }

    /** Runs the run loop for the lifetime of the parameter sent to `holdDriver`, and executes `cleanUp` when the run loop stops.

     - SeeAlso: `runForDriver(holdDriver:)`
     */
    public func runForDriver(@noescape holdDriver holdDriver: (RunLoopDriver) -> (), @noescape withCleanUp cleanUp: () -> ()) {
        runForDriver(holdDriver: holdDriver)
        cleanUp()
    }
}
