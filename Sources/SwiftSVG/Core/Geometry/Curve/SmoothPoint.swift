//
//  Created by Kurlovich Vitali on 8/4/26.
//

public struct SmoothPoint: Sendable, Hashable {
    public var control2: Point
    public var p: Point

    @inlinable
    public init(to p: Point, control2: Point) {
        self.control2 = control2
        self.p = p
    }
}

public extension SmoothPoint {
    @inlinable
    static func + (lhs: SmoothPoint, rhs: SmoothVector) -> SmoothPoint {
        SmoothPoint(to: lhs.p + rhs.v, control2: lhs.control2 + rhs.control2)
    }

    @inlinable
    static func - (lhs: SmoothPoint, rhs: SmoothVector) -> SmoothPoint {
        SmoothPoint(to: lhs.p - rhs.v, control2: lhs.control2 - rhs.control2)
    }
}
