//
//  Created by Kurlovich Vitali on 8/4/26.
//

public struct SmoothPoint: Sendable, Hashable {
    public var p2: Point
    public var p: Point
}

public struct SmoothVector: Sendable, Hashable {
    public var v2: Vector
    public var v: Vector
}

public extension SmoothPoint {
    static func + (lhs: SmoothPoint, rhs: SmoothVector) -> SmoothPoint {
        SmoothPoint(p2: lhs.p2 + rhs.v2, p: lhs.p + rhs.v)
    }

    static func - (lhs: SmoothPoint, rhs: SmoothVector) -> SmoothPoint {
        SmoothPoint(p2: lhs.p2 - rhs.v2, p: lhs.p - rhs.v)
    }
}
