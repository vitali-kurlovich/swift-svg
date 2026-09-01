//
//  Created by Kurlovich Vitali on 8/4/26.
//

import CGMathKit
import CoreGraphics

public struct SmoothPoint: Sendable, Hashable {
    public var target: CGPoint
    public var control2: CGPoint

    @inlinable
    public init(to target: CGPoint, control2: CGPoint) {
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
