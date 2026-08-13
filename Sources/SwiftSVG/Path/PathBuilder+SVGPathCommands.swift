//
//  Created by Kurlovich Vitali on 8/13/26.
//

public extension PathBuilder {
    mutating func execute(_ commands: SVGPathCommands) {
        for command in commands {
            apply(command)
        }
    }
}

private extension PathBuilder {
    mutating func apply(_ command: SVGPathCommand) {
        switch command {
        case let .move(point):
            move(to: point)
        case let .moveRelative(offset):
            move(by: offset)
        case let .line(points):
            addLines(points)
        case let .lineRelative(offsets):
            addLines(offsets)
        case let .horizontal(point):
            addLine(to: point)
        case let .horizontalRelative(offset):
            addLine(by: offset)
        case let .vertical(point):
            addLine(to: point)
        case let .verticalRelative(offset):
            addLine(by: offset)
        case let .cubic(points):
            addCurves(points)
        case let .cubicRelative(offsets):
            addCurves(offsets)
        case let .smooth(points):
            addCurves(points)
        case let .smoothRelative(offsets):
            addCurves(offsets)
        case let .quadratic(points):
            addQuadCurves(points)
        case let .quadraticRelative(offsets):
            addQuadCurves(offsets)
        case let .smoothQuadratic(points):
            addQuadCurves(points)
        case let .smoothQuadraticRelative(offsets):
            addQuadCurves(offsets)
        case let .arc(arcs):
            addArcs(arcs)
        case let .arcRelative(arcs):
            addArcs(arcs)
        case .closePath:
            closeSubpath()
        }
    }
}
