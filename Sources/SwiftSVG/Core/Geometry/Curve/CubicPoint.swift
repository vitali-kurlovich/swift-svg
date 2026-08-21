//
//  Created by Kurlovich Vitali on 8/4/26.
//

import MathKit

public struct CubicPoint: Sendable, Hashable {
    public var target: Point
    public var control1: Point
    public var control2: Point

    @inlinable
    public init(to target: Point, control1: Point, control2: Point) {
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
