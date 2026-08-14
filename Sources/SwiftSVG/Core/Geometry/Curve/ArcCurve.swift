//
//  Created by Kurlovich Vitali on 8/12/26.
//

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

import Foundation

extension ArcTangentCurve {
    init(current: Point, arc: ArcCurve) {
        let r = arc.radius.width

        let p0 = current
        let p2 = arc.end

        let dd: Vector = p2 - p0

        let D = (dd.dx * dd.dx + dd.dy * dd.dy).squareRoot()

        let alpha = asin(D / (2 * r))

        self.init(radius: r, tangent1: .zero, tangent2: .zero)
    }
}
