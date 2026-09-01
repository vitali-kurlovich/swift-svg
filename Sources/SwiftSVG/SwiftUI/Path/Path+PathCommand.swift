//
//  Created by Kurlovich Vitali on 8/5/26.
//

import struct CoreGraphics.CGPoint
import struct SwiftUI.Path

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
    public var lastPoint: CGPoint {
        currentPoint ?? .zero
    }

    public mutating func addCurve(_ points: CubicPoint) {
        addCurve(to: points.target, control1: points.control1, control2: points.control2)
    }

    public mutating func addQuadCurve(_ point: QuadraticPoint) {
        addQuadCurve(to: point.target, control: point.control1)
    }
}
