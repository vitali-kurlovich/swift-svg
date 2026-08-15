//
//  CGPath+PathBuilder.swift
//  swift-svg
//
//  Created by Kurlovich Vitali on 8/15/26.
//

import CoreGraphics

extension CGMutablePath: PathBuilder {
    public var lastPoint: Point {
        Point(currentPoint)
    }

    public func move(to point: Point) {
        move(to: .init(point))
    }

    public func addLine(to point: Point) {
        addLine(to: .init(point))
    }

    public func addCurve(_ point: CubicPoint) {
        addCurve(
            to: .init(point.target),
            control1: .init(point.control1),
            control2: .init(point.control2),
        )
    }

    public func addQuadCurve(_ point: QuadraticPoint) {
        addQuadCurve(
            to: .init(point.target),
            control: .init(point.control1),
        )
    }
}

public extension CGPath {
    static func path(with commands: some Sequence<PathCommand>) -> CGPath? {
        mutablePath(with: commands).copy()
    }

    static func mutablePath(with commands: some Sequence<PathCommand>) -> CGMutablePath {
        var path = CGMutablePath()
        path.execute(commands)
        return path
    }
}
