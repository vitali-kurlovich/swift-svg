//
//  Created by Kurlovich Vitali on 8/4/26.
//

public struct VerticalPoint: Sendable, Hashable {
    public var y: Double
}

public struct VerticalVector: Sendable, Hashable {
    public var dy: Double
}

public extension VerticalPoint {
    static func + (lhs: VerticalPoint, rhs: VerticalVector) -> VerticalPoint {
        .init(y: lhs.y + rhs.dy)
    }

    static func - (lhs: VerticalPoint, rhs: VerticalVector) -> VerticalPoint {
        .init(y: lhs.y - rhs.dy)
    }
}

public extension VerticalPoint {
    static func - (lhs: VerticalPoint, rhs: VerticalPoint) -> VerticalVector {
        .init(dy: lhs.y - rhs.y)
    }
}

public extension Point {
    static func + (lhs: Point, rhs: VerticalVector) -> Point {
        .init(x: lhs.x, y: lhs.y + rhs.dy)
    }

    static func - (lhs: Point, rhs: VerticalVector) -> Point {
        .init(x: lhs.x, y: lhs.y - rhs.dy)
    }
}
