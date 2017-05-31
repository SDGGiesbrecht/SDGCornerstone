/*
 SharedValueObserverExample.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone/macOS

 Copyright ©2017 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCornerstone

class SharedValueObserverExample : SharedValueObserver {

    // Initialization

    init(_ value: Shared<Int>, normalizing: Bool) {
        self.value = value
        self.normalizing = normalizing
        value.register(observer: self)
    }

    // Properties

    var value: Shared<Int>
    var lastReportedValue: Int?
    var normalizing: Bool

    // SharedValueObserver

    func valueChanged(for identifier: String) {
        lastReportedValue = value.value

        if normalizing {
            if value.value ≠ 0 {
                value.value = 0
            }
        }
    }
}
