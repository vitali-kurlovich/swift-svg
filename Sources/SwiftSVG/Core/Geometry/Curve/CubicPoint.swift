//
//  Created by Kurlovich Vitali on 8/4/26.
//

import CGMathKit
import CoreGraphics

public struct CubicPoint: Sendable, Hashable {
    public var target: CGPoint
    public var control1: CGPoint
    public var control2: CGPoint

    @inlinable
    public init(to target: CGPoint, control1: CGPoint, control2: CGPoint) {
        self.target = target
        self.control1 = control1
        self.control2 = control2
    }
}

public extension CubicPoint {
    @inlinable
    static func + (lhs: CubicPoint, rhs: CubicVector) -> CubicPoint {
        .init(to: lhs.target + rhs.target, control1: lhs.control1 + rhs.control1, control2: lhs.control2 + rhs.control2)
    }

    @inlinable
    static func - (lhs: CubicPoint, rhs: CubicVector) -> CubicPoint {
        .init(to: lhs.target - rhs.target,
              control1: lhs.control1 - rhs.control1,
              control2: lhs.control2 - rhs.control2)
    }

    @inlinable
    static func += (left: inout CubicPoint, right: CubicVector) {
        left.control1 += right.control1
        left.control2 += right.control2
        left.target += right.target
    }

    @inlinable
    static func -= (left: inout CubicPoint, right: CubicVector) {
        left.control1 -= right.control1
        left.control2 -= right.control2
        left.target -= right.target
    }
}
