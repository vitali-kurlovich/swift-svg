//
//  Created by Kurlovich Vitali on 8/4/26.
//

public struct QuadraticPoint: Sendable, Hashable {
    public var target: Point
    public var control1: Point
   
    @inlinable
    public init(control1: Point, p: Point) {
        self.control1 = control1
        self.target = p
    }
}

public extension QuadraticPoint {
    @inlinable
    static func + (lhs: QuadraticPoint, rhs: QuadraticVector) -> QuadraticPoint {
        .init(control1: lhs.control1 + rhs.control1, p: lhs.target + rhs.v)
    }

    @inlinable
    static func - (lhs: QuadraticPoint, rhs: QuadraticVector) -> QuadraticPoint {
        .init(control1: lhs.control1 - rhs.control1, p: lhs.target - rhs.v)
    }
}
