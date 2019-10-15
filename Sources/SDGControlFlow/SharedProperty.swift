/*
 SharedProperty.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

@propertyWrapper public final class SharedProperty<Value> : DefaultAssignmentPropertyWrapper, ProjectingPropertyWrapper, TransparentWrapper {

    /// Creates a shared property with a shared value.
    ///
    /// - Parameters:
    ///     - sharedValue: The shared value.
    public init(_ sharedValue: Shared<Value>) {
        self.projectedValue = sharedValue
    }

    /// Creates a shared property with a value.
    ///
    /// - Parameters:
    ///     - value: The value.
    public convenience init(_ value: Value) {
        self.init(Shared(value))
    }

    // MARK: - DefaultAssignmentPropertyWrapper

    public convenience init(wrappedValue: Value) {
        self.init(wrappedValue)
    }

    // MARK: - ProjectingPropertyWrapper

    public var projectedValue: Shared<Value>

    // MARK: - PropertyWrapper

    public var wrappedValue: Value {
        get {
            return projectedValue.value
        }
        set {
            projectedValue.value = newValue
        }
    }

    // MARK: - TransparentWrapper

    public var wrappedInstance: Any {
        return projectedValue
    }
}
