//
//  Created by Kurlovich Vitali on 8/4/26.
//

public struct SmoothPoint: Sendable, Hashable {
    public var target: Point
    public var control2: Point

    @inlinable
    public init(to target: Point, control2: Point) {
        self.target = target
        self.control2 = control2
    }
}

public extension SmoothPoint {
    @inlinable
    static func + (lhs: SmoothPoint, rhs: SmoothVector) -> SmoothPoint {
        SmoothPoint(
            to: lhs.target + rhs.target,
            control2: lhs.control2 + rhs.control2,
        )
    }

    @inlinable
    static func - (lhs: SmoothPoint, rhs: SmoothVector) -> SmoothPoint {
        SmoothPoint(
            to: lhs.target - rhs.target,
            control2: lhs.control2 - rhs.control2,
        )
    }
}
