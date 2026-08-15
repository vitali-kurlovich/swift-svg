//
//  Created by Kurlovich Vitali on 8/4/26.
//

public struct QuadraticPoint: Sendable, Hashable {
    public var target: Point
    public var control1: Point

    @inlinable
    public init(to target: Point, control1: Point) {
        self.target = target
        self.control1 = control1
    }
}

public extension QuadraticPoint {
    @inlinable
    static func + (lhs: QuadraticPoint, rhs: QuadraticVector) -> QuadraticPoint {
        .init(
            to: lhs.target + rhs.target,
            control1: lhs.control1 + rhs.control1,
        )
    }

    @inlinable
    static func - (lhs: QuadraticPoint, rhs: QuadraticVector) -> QuadraticPoint {
        .init(
            to: lhs.target - rhs.target,
            control1: lhs.control1 - rhs.control1,
        )
    }
}
