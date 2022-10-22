/*
 Be_zierPath.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.6.1, Should be “BézierPath.swift” but for Windows bug.)

#if PLATFORM_HAS_COCOA
  #if canImport(AppKit)
    import AppKit
  #elseif canImport(UIKit)
    import UIKit
  #endif

  import SDGMathematics

  /// A Bézier path.
  public struct BézierPath: CustomPlaygroundDisplayConvertible {

    // MARK: - Initialization

    /// Creates an empty Bézier path.
    public init() {
      #if canImport(AppKit)
        self.init(NSBezierPath())
      #elseif canImport(UIKit)
        self.init(UIBezierPath())
      #endif
    }

    #if canImport(AppKit)
      // @documentation(BézierPath.init(native:))
      /// Creates a Bézier path with a native Bézier path.
      ///
      /// - Parameters:
      ///     - native: The native Bézier path.
      public init(_ native: NSBezierPath) {
        self.native = native
        separateCopy()
      }
    #elseif canImport(UIKit)
      // #documentation(BézierPath.init(native:))
      /// Creates a Bézier path with a native Bézier path.
      ///
      /// - Parameters:
      ///     - native: The native Bézier path.
      public init(_ native: UIBezierPath) {
        self.native = native
        separateCopy()
      }
    #endif

    // MARK: - Properties

    #if canImport(AppKit)
      // @documentation(BézierPath.native)
      /// The native Bézier path.
      public private(set) var native: NSBezierPath
    #elseif canImport(UIKit)
      // #documentation(BézierPath.native)
      /// The native Bézier path.
      public private(set) var native: UIBezierPath
    #endif

    private mutating func separateCopy() {
      #if canImport(AppKit)
        native = native.copy() as! NSBezierPath
      #elseif canImport(UIKit)
        native = native.copy() as! UIBezierPath
      #endif
    }

    // MARK: - Drawing

    /// Moves the current point to a new location without drawing anything in between.
    ///
    /// - Parameters:
    ///     - point: The destination to move to.
    public mutating func move(to point: TwoDimensionalPoint<Double>) {
      separateCopy()
      native.move(to: CGPoint(point))
    }

    /// Appends a straight line to the path.
    ///
    /// - Parameters:
    ///     - point: The target point.
    public mutating func appendLine(to point: TwoDimensionalPoint<Double>) {
      separateCopy()
      #if canImport(AppKit)
        native.line(to: CGPoint(point))
      #elseif canImport(UIKit)
        native.addLine(to: CGPoint(point))
      #endif
    }

    /// Appends an arc of a circle to the path.
    ///
    /// - Parameters:
    ///     - centre: The centre point of the circle used to define the arc.
    ///     - radius: The radius of the arc.
    ///     - startAngle: The starting angle of the arc, measured counterclockwise from the x‐axis.
    ///     - endAngle: The end angle of the arc, measured counterclockwise from the x‐axis.
    ///     - clockwise: Whether or not the arc should be drawn in the clockwise direction.
    public mutating func appendArc(
      centre: TwoDimensionalPoint<Double>,
      radius: Double,
      startAngle: Angle<Double>,
      endAngle: Angle<Double>,
      clockwise: Bool
    ) {

      separateCopy()

      #if canImport(AppKit)
        return native.appendArc(
          withCenter: CGPoint(centre),
          radius: CGFloat(radius),
          startAngle: CGFloat(startAngle.inDegrees),
          endAngle: CGFloat(endAngle.inDegrees),
          clockwise: clockwise
        )
      #elseif canImport(UIKit)
        return native.addArc(
          withCenter: CGPoint(centre),
          radius: CGFloat(radius),
          startAngle: CGFloat(startAngle.inDegrees),
          endAngle: CGFloat(endAngle.inDegrees),
          clockwise: clockwise
        )
      #endif
    }

    // MARK: - CustomPlaygroundDisplayConvertible

    public var playgroundDescription: Any {
      return native
    }
  }
#endif
