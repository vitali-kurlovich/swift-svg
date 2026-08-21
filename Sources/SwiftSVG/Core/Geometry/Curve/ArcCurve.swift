//
//  Created by Kurlovich Vitali on 8/12/26.
//

import MathKit

public struct ArcCurve: Sendable, Hashable {
    public var radius: Size
    public var end: Point

    public var angle: Double

    public var options: ArcCurveOptions

    public init(
        radius: Size,
        end: Point,
        angle: Double,
        options: ArcCurveOptions,
    ) {
        self.radius = radius
        self.end = end
        self.angle = angle
        self.options = options
    }
}

public struct ArcOffsetCurve: Sendable, Hashable {
    public var radius: Size
    public var end: Vector

    public var angle: Double

    public var options: ArcCurveOptions

    public init(
        radius: Size,
        end: Vector,
        angle: Double,
        options: ArcCurveOptions,
    ) {
        self.radius = radius
        self.end = end
        self.angle = angle
        self.options = options
    }
}

public struct ArcCurveOptions: OptionSet, Sendable, Hashable {
    public var rawValue: UInt8

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }

    public static let drawLargerArc: Self = .init(rawValue: 1 << 0)
    public static let clockwise: Self = .init(rawValue: 1 << 1)
}

public struct ArcTangentCurve: Sendable, Hashable {
    public var radius: Double
    public var tangent1: Point
    public var tangent2: Point

    public init(radius: Double, tangent1: Point, tangent2: Point) {
        self.radius = radius
        self.tangent1 = tangent1
        self.tangent2 = tangent2
    }
}
