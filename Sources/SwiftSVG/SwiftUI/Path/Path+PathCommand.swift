//
//  Created by Kurlovich Vitali on 8/5/26.
//

import struct SwiftUI.Path
import struct CoreGraphics.CGPoint

public extension Path {
    init(path: String) {
        self.init(SVGPathCommands(path))
    }

    init(_ commands: some Sequence<PathCommand>) {
        self.init()
        execute(commands)
    }
}

extension Path: PathBuilder {
    public var lastPoint: Point {
        Point(currentPoint ?? .zero)
    }

    public mutating func move(to point: Point) {
        move(to: CGPoint(point))
    }

    public mutating func addLine(to point: Point) {
        addLine(to: CGPoint(point))
    }

    public mutating func addCurve(_ points: CubicPoint) {
        addCurve(to: CGPoint(points.target), control1: CGPoint(points.control1), control2: CGPoint(points.control2))
    }

    public mutating func addQuadCurve(_ point: QuadraticPoint) {
        addQuadCurve(to: CGPoint(point.target), control: CGPoint(point.control1))
    }
}
