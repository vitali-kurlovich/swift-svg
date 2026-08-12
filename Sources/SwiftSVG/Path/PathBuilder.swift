//
//  Created by Kurlovich Vitali on 8/12/26.
//

public protocol PathBuilder {
    var lastPoint: Point { get }

    mutating func move(to point: Point)
    mutating func move(by offset: Vector)

    mutating func addLine(to point: Point)
    mutating func addLines(_ points: some Sequence<Point>)

    mutating func addLine(by offset: Vector)
    mutating func addLines(_ offsets: some Sequence<Vector>)

    mutating func addLine(to horizontal: HorizontalPoint)
    mutating func addLine(by horizontal: HorizontalVector)

    mutating func addCurve(_ point: CubicPoint)
    mutating func addCurves(_ points: some Sequence<CubicPoint>)

    mutating func addCurve(_ offset: CubicVector)
    mutating func addCurves(_ offsets: some Sequence<CubicVector>)

    mutating func addCurve(_ point: SmoothPoint)
    mutating func addCurves(_ points: some Sequence<SmoothPoint>)

    mutating func addCurve(_ offset: SmoothVector)
    mutating func addCurves(_ offsets: some Sequence<SmoothVector>)

    mutating func addQuadCurve(_ point: QuadraticPoint)
    mutating func addQuadCurves(_ points: some Sequence<QuadraticPoint>)

    mutating func addQuadCurve(_ offset: QuadraticVector)
    mutating func addQuadCurves(_ offsets: some Sequence<QuadraticVector>)

    mutating func addQuadCurve(_ point: Point)
    mutating func addQuadCurves(_ points: some Sequence<Point>)

    mutating func addQuadCurve(_ offset: Vector)
    mutating func addQuadCurves(_ offsets: some Sequence<Vector>)

    mutating func closeSubpath()
}

public extension PathBuilder {
    mutating func addQuadCurve(_ offset: QuadraticVector) {
        let p = lastPoint + offset.v
        let p1 = p + offset.v1
        addQuadCurve(QuadraticPoint(p1: p1, p: p))
    }

    mutating func addQuadCurves(_ points: some Sequence<QuadraticPoint>) {
        for point in points {
            addQuadCurve(point)
        }
    }

    mutating func addQuadCurves(_ offsets: some Sequence<QuadraticVector>) {
        var p = lastPoint
        for offset in offsets {
            p += offset.v
            let p1 = p + offset.v1

            addQuadCurve(QuadraticPoint(p1: p1, p: p))
        }
    }
}

// TODO: Fix control point
public extension PathBuilder {
    mutating func addQuadCurve(_ point: Point) {
        let p = point
        let p1 = p

        addQuadCurve(QuadraticPoint(p1: p1, p: p))
    }

    mutating func addQuadCurves(_ points: some Sequence<Point>) {
        for point in points {
            addQuadCurve(point)
        }
    }

    mutating func addQuadCurve(_ offset: Vector) {
        let p = lastPoint + offset
        let p1 = p

        addQuadCurve(QuadraticPoint(p1: p1, p: p))
    }

    mutating func addQuadCurves(_ offsets: some Sequence<Vector>) {
        for offset in offsets {
            addQuadCurve(offset)
        }
    }
}

public extension PathBuilder {
    mutating func move(by offset: Vector) {
        let point = lastPoint + offset
        move(to: point)
    }
}

public extension PathBuilder {
    mutating func addLine(by offset: Vector) {
        let point = lastPoint + offset
        addLine(to: point)
    }

    mutating func addLines(_ points: some Sequence<Point>) {
        for point in points {
            addLine(to: point)
        }
    }

    mutating func addLines(_ offsets: some Sequence<Vector>) {
        var point = lastPoint

        for offset in offsets {
            point += offset
            addLine(to: point)
        }
    }
}

public extension PathBuilder {
    mutating func addLine(to horizontal: HorizontalPoint) {
        var point = lastPoint
        point.x = horizontal.x
        addLine(to: point)
    }

    mutating func addLine(by horizontal: HorizontalVector) {
        let point = lastPoint + horizontal

        addLine(to: point)
    }
}

public extension PathBuilder {
    mutating func addLine(to vertical: VerticalPoint) {
        var point = lastPoint
        point.y = vertical.y
        addLine(to: point)
    }

    mutating func addLine(by vertical: VerticalVector) {
        let point = lastPoint + vertical
        addLine(to: point)
    }
}

public extension PathBuilder {
    mutating func addCurve(_ offset: CubicVector) {
        let p = lastPoint + offset.v
        let ps = CubicPoint(p1: p + offset.v1,
                            p2: p + offset.v2,
                            p: p)
        addCurve(ps)
    }

    mutating func addCurves(_ points: some Sequence<CubicPoint>) {
        for p in points {
            addCurve(p)
        }
    }

    mutating func addCurves(_ offsets: some Sequence<CubicVector>) {
        var p = lastPoint
        for offset in offsets {
            p += offset.v

            let ps = CubicPoint(p1: p + offset.v1,
                                p2: p + offset.v2,
                                p: p)

            addCurve(ps)
        }
    }
}

public extension PathBuilder {
    mutating func addCurve(_ point: SmoothPoint) {
        let p = point.p
        let p2 = point.p2

        let v1: Vector = p2 - p

        let p1 = p + v1

        addCurve(CubicPoint(p1: p1, p2: p2, p: p))
    }

    mutating func addCurves(_ points: some Sequence<SmoothPoint>) {
        for point in points {
            addCurve(point)
        }
    }

    mutating func addCurve(_ offset: SmoothVector) {
        let p = lastPoint + offset.v
        let p2 = p + offset.v2
        let v1: Vector = p2 - p
        let p1 = p + v1
        addCurve(CubicPoint(p1: p1, p2: p2, p: p))
    }

    mutating func addCurves(_ offsets: some Sequence<SmoothVector>) {
        for offset in offsets {
            addCurve(offset)
        }
    }
}

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
        case .closePath:
            closeSubpath()
        }
    }
}
