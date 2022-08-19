/*
 SendableValueCache.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Dispatch

/// A sendable cache which can be used as a property by value types to record derived properties without semantically mutating.
///
/// - Warning: Every real mutation to the parent value must reset the cache by creating a new instance.
public struct SendableValueCache<T>: @unchecked Sendable where T: Sendable {

  // MARK: - Initialization

  /// Creates a cache.
  ///
  /// - Parameters:
  ///   - contents: The contents.
  @inlinable public init(contents: T) {
    self.rawCache = RawCache(contents: contents)
  }

  // MARK: - Properties

  @usableFromInline internal class RawCache {
    @inlinable internal init(contents: T) {
      self.contents = contents
    }
    @usableFromInline internal var contents: T
  }
  @usableFromInline internal var rawCache: RawCache
  @usableFromInline internal let semaphore = DispatchSemaphore(value: 1)

  /// The contents of the cache.
  @inlinable public var contents: T {
    get {
      semaphore.wait()
      let contents = rawCache.contents
      semaphore.signal()
      return contents
    }
    nonmutating set {
      semaphore.wait()
      rawCache.contents = newValue
      semaphore.signal()
    }
  }
}
