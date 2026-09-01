//
//  Created by Kurlovich Vitali on 8/4/26.
//

import CGMathKit
import CoreGraphics

public struct QuadraticPoint: Sendable, Hashable {
    public var target: CGPoint
    public var control1: CGPoint

    @inlinable
    public init(to target: CGPoint, control1: CGPoint) {
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
