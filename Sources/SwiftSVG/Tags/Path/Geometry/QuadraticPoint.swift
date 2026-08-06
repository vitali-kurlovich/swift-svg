//
//  Created by Kurlovich Vitali on 8/4/26.
//

public struct QuadraticPoint: Sendable, Hashable {
    public var p1: Point
    public var p: Point
}

public struct QuadraticVector: Sendable, Hashable {
    public var v1: Vector
    public var v: Vector
}

public extension QuadraticPoint {
    static func + (lhs: QuadraticPoint, rhs: QuadraticVector) -> QuadraticPoint {
        .init(p1: lhs.p1 + rhs.v1, p: lhs.p + rhs.v)
    }

    static func - (lhs: QuadraticPoint, rhs: QuadraticVector) -> QuadraticPoint {
        .init(p1: lhs.p1 - rhs.v1, p: lhs.p - rhs.v)
    }
}
