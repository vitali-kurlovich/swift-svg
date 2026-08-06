//
//  Created by Kurlovich Vitali on 8/4/26.
//

public struct HorizontalPoint: Sendable, Hashable {
    public var x: Double
}

public struct HorizontalVector: Sendable, Hashable {
    public var dx: Double
}

public extension HorizontalPoint {
    static func + (lhs: HorizontalPoint, rhs: HorizontalVector) -> HorizontalPoint {
        .init(x: lhs.x + rhs.dx)
    }

    static func - (lhs: HorizontalPoint, rhs: HorizontalVector) -> HorizontalPoint {
        .init(x: lhs.x - rhs.dx)
    }
}

public extension HorizontalPoint {
    static func - (lhs: HorizontalPoint, rhs: HorizontalPoint) -> HorizontalVector {
        .init(dx: lhs.x - rhs.x)
    }
}

public extension Point {
    static func + (lhs: Point, rhs: HorizontalVector) -> Point {
        .init(x: lhs.x + rhs.dx, y: lhs.y)
    }

    static func - (lhs: Point, rhs: HorizontalVector) -> Point {
        .init(x: lhs.x - rhs.dx, y: lhs.y)
    }
}
