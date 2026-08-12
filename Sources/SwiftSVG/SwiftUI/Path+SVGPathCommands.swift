//
//  Created by Kurlovich Vitali on 8/5/26.
//

import struct SwiftUI.Path

public extension Path {
    init(path: String) {
        self.init(SVGPathCommands(path))
    }

    init(_ commands: SVGPathCommands) {
        self.init()
        execute(commands)
    }
}

extension Path: PathBuilder {
    public var lastPoint: Point {
        Point(currentPoint ?? .zero)
    }

    public mutating func move(to point: Point) {
        move(to: .init(point))
    }

    public mutating func addLine(to point: Point) {
        addLine(to: .init(point))
    }

    public mutating func addCurve(_ points: CubicPoint) {
        addCurve(to: .init(points.p), control1: .init(points.p1), control2: .init(points.p2))
    }

    public mutating func addQuadCurve(_ point: QuadraticPoint) {
        addQuadCurve(to: .init(point.p), control: .init(point.p1))
    }
}
