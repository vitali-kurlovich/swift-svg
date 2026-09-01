//
//  Created by Kurlovich Vitali on 8/15/26.
//

import CoreGraphics

extension CGMutablePath: PathBuilder {
    public var lastPoint: CGPoint {
        currentPoint
    }

    public func move(to point: CGPoint) {
        move(to: point, transform: .identity)
    }

    public func addLine(to point: CGPoint) {
        addLine(to: point, transform: .identity)
    }

    public func addCurve(_ point: CubicPoint) {
        addCurve(
            to: point.target,
            control1: point.control1,
            control2: point.control2,
        )
    }

    public func addQuadCurve(_ point: QuadraticPoint) {
        addQuadCurve(
            to: point.target,
            control: point.control1,
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
