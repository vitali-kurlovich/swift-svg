//
//  Created by Kurlovich Vitali on 8/4/26.
//

public struct CubicPoint: Sendable, Hashable {
    public var control1: Point
    public var control2: Point
    public var p: Point

    @inlinable
    public init(control1: Point, control2: Point, p: Point) {
        self.control1 = control1
        self.control2 = control2
        self.p = p
    }
}

public extension CubicPoint {
    @inlinable
    static func + (lhs: CubicPoint, rhs: CubicVector) -> CubicPoint {
        .init(control1: lhs.control1 + rhs.control1, control2: lhs.control2 + rhs.control2, p: lhs.p + rhs.v)
    }

    @inlinable
    static func - (lhs: CubicPoint, rhs: CubicVector) -> CubicPoint {
        .init(control1: lhs.control1 - rhs.control1,
              control2: lhs.control2 - rhs.control2,
              p: lhs.p - rhs.v)
    }

    @inlinable
    static func += (left: inout CubicPoint, right: CubicVector) {
        left.control1 += right.control1
        left.control2 += right.control2
        left.p += right.v
    }

    @inlinable
    static func -= (left: inout CubicPoint, right: CubicVector) {
        left.control1 -= right.control1
        left.control2 -= right.control2
        left.p -= right.v
    }
}
