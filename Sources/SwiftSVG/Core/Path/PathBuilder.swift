//
//  Created by Kurlovich Vitali on 8/12/26.
//

import Foundation

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

    mutating func addArc(_ arc: ArcCurve)
    mutating func addArcs(_ arcs: some Sequence<ArcCurve>)

    mutating func addArc(_ arc: ArcOffsetCurve)
    mutating func addArcs(_ arcs: some Sequence<ArcOffsetCurve>)

    mutating func closeSubpath()
}

public extension PathBuilder {
    mutating func addQuadCurve(_ offset: QuadraticVector) {
        let target = lastPoint + offset.target
        let cp1 = target + offset.control1
        addQuadCurve(QuadraticPoint(to: target, control1: cp1))
    }

    mutating func addQuadCurves(_ points: some Sequence<QuadraticPoint>) {
        for point in points {
            addQuadCurve(point)
        }
    }

    mutating func addQuadCurves(_ offsets: some Sequence<QuadraticVector>) {
        var target = lastPoint
        for offset in offsets {
            target += offset.target
            let cp1 = target + offset.control1

            addQuadCurve(QuadraticPoint(to: target, control1: cp1))
        }
    }
}

// TODO: Fix control point
public extension PathBuilder {
    mutating func addQuadCurve(_ target: Point) {
        let cp1 = target

        addQuadCurve(QuadraticPoint(to: target, control1: cp1))
    }

    mutating func addQuadCurves(_ points: some Sequence<Point>) {
        for point in points {
            addQuadCurve(point)
        }
    }

    mutating func addQuadCurve(_ offset: Vector) {
        let target = lastPoint + offset
        let cp1 = target

        addQuadCurve(QuadraticPoint(to: target, control1: cp1))
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
        let p = lastPoint + offset.target
        let ps = CubicPoint(to: p, control1: p + offset.control1, control2: p + offset.control2)
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
            p += offset.target
            let ps = CubicPoint(to: p, control1: p + offset.control1, control2: p + offset.control2)
            addCurve(ps)
        }
    }
}

public extension PathBuilder {
    mutating func addCurve(_ point: SmoothPoint) {
        let p = point.target
        let cp2 = point.control2

        let v1: Vector = cp2 - p

        let cp1 = p + v1

        addCurve(CubicPoint(to: p, control1: cp1, control2: cp2))
    }

    mutating func addCurves(_ points: some Sequence<SmoothPoint>) {
        for point in points {
            addCurve(point)
        }
    }

    mutating func addCurve(_ offset: SmoothVector) {
        let target = lastPoint + offset.target
        let cp2 = target + offset.control2
        let v1: Vector = cp2 - target
        let cp1 = target + v1
        addCurve(CubicPoint(to: target, control1: cp1, control2: cp2))
    }

    mutating func addCurves(_ offsets: some Sequence<SmoothVector>) {
        for offset in offsets {
            addCurve(offset)
        }
    }
}

public extension PathBuilder {
    mutating func addArc(_ arc: ArcOffsetCurve) {
        let end = lastPoint + arc.end

        let arc = ArcCurve(
            radius: arc.radius,
            end: end,
            angle: arc.angle,
            options: arc.options,
        )

        addArc(arc)
    }

    mutating func addArcs(_ arcs: some Sequence<ArcCurve>) {
        for arc in arcs {
            addArc(arc)
        }
    }

    mutating func addArcs(_ arcs: some Sequence<ArcOffsetCurve>) {
        var end = lastPoint

        for arc in arcs {
            end += arc.end

            let arc = ArcCurve(
                radius: arc.radius,
                end: end,
                angle: arc.angle,
                options: arc.options,
            )

            addArc(arc)
        }
    }
}

public extension PathBuilder {
    mutating func addArc(_ arc: ArcCurve) {
        var rx = abs(arc.radius.width)
        var ry = abs(arc.radius.height)

        let currentPoint = lastPoint
        let endPoint: Point = arc.end
        // Degenerate cases: radii are 0 or start == end -> draw a line segment
        guard rx > 0, ry > 0, currentPoint != endPoint else {
            addLine(to: endPoint)
            return
        }

        let largeArcFlag = arc.options.contains(.drawLargerArc)
        let sweepFlag = arc.options.contains(.clockwise)

        let phi = arc.angle * .pi / 180.0
        let cosPhi = cos(phi)
        let sinPhi = sin(phi)

        // -------------------------------------------------------------
        // Step 1: Compute transformed midpoint (x1', y1')
        // -------------------------------------------------------------
        let dx = (currentPoint.x - endPoint.x) / 2.0
        let dy = (currentPoint.y - endPoint.y) / 2.0
        let x1p = cosPhi * dx + sinPhi * dy
        let y1p = -sinPhi * dx + cosPhi * dy

        // Correct radii if they are too small to bridge x1p/y1p
        let lambda = (x1p * x1p) / (rx * rx) + (y1p * y1p) / (ry * ry)
        if lambda > 1.0 {
            let sqrtLambda = sqrt(lambda)
            rx *= sqrtLambda
            ry *= sqrtLambda
        }

        // -------------------------------------------------------------
        // Step 2: Compute transformed center (cx', cy')
        // -------------------------------------------------------------
        let rx2 = rx * rx
        let ry2 = ry * ry
        let x1p2 = x1p * x1p
        let y1p2 = y1p * y1p

        var numerator = rx2 * ry2 - rx2 * y1p2 - ry2 * x1p2
        numerator = max(0, numerator) // Prevent floating point accuracy negative values
        let denominator = rx2 * y1p2 + ry2 * x1p2

        let sign: CGFloat = (largeArcFlag == sweepFlag) ? -1.0 : 1.0
        let factor = sign * sqrt(numerator / denominator)

        let cxp = factor * (rx * y1p / ry)
        let cyp = factor * (-ry * x1p / rx)

        // -------------------------------------------------------------
        // Step 3: Compute actual center (cx, cy)
        // -------------------------------------------------------------
        let cx = cosPhi * cxp - sinPhi * cyp + (currentPoint.x + endPoint.x) / 2.0
        let cy = sinPhi * cxp + cosPhi * cyp + (currentPoint.y + endPoint.y) / 2.0
        let center = CGPoint(x: cx, y: cy)

        /// -------------------------------------------------------------
        /// Step 4: Compute Start Angle & Delta Angle
        /// -------------------------------------------------------------
        func vectorAngle(u: CGPoint, v: CGPoint) -> CGFloat {
            let dot = u.x * v.x + u.y * v.y
            let len = sqrt(u.x * u.x + u.y * u.y) * sqrt(v.x * v.x + v.y * v.y)
            let cosAngle = max(-1.0, min(1.0, dot / len))
            var ang = acos(cosAngle)
            if (u.x * v.y - u.y * v.x) < 0 {
                ang = -ang
            }
            return ang
        }

        let v1 = CGPoint(x: (x1p - cxp) / rx, y: (y1p - cyp) / ry)
        let v2 = CGPoint(x: (-x1p - cxp) / rx, y: (-y1p - cyp) / ry)

        let startAngle = vectorAngle(u: CGPoint(x: 1, y: 0), v: v1)
        var deltaAngle = vectorAngle(u: v1, v: v2).truncatingRemainder(dividingBy: .pi * 2)

        if !sweepFlag, deltaAngle > 0 {
            deltaAngle -= .pi * 2
        } else if sweepFlag, deltaAngle < 0 {
            deltaAngle += .pi * 2
        }

        // -------------------------------------------------------------
        // Step 5: Decompose Arc into Cubic Bézier Curves
        // -------------------------------------------------------------
        let numSegments = Int(ceil(abs(deltaAngle) / (.pi / 2.0)))
        guard numSegments > 0 else { return }

        let segmentAngle = deltaAngle / CGFloat(numSegments)
        let k = (4.0 / 3.0) * tan(segmentAngle / 4.0)

        func transformPoint(x: Double, y: Double) -> Point {
            let scaledX = x * rx
            let scaledY = y * ry
            let rotatedX = cosPhi * scaledX - sinPhi * scaledY
            let rotatedY = sinPhi * scaledX + cosPhi * scaledY
            return Point(x: rotatedX + center.x, y: rotatedY + center.y)
        }

        for i in 0 ..< numSegments {
            let a1 = startAngle + Double(i) * segmentAngle
            let a2 = a1 + segmentAngle

            let cos1 = cos(a1), sin1 = sin(a1)
            let cos2 = cos(a2), sin2 = sin(a2)

            // Unit circle control points
            let uCP1 = Point(x: cos1 - k * sin1, y: sin1 + k * cos1)
            let uCP2 = Point(x: cos2 + k * sin2, y: sin2 - k * cos2)

            // Map back to ellipse coordinate space
            let cp1 = transformPoint(x: uCP1.x, y: uCP1.y)
            let cp2 = transformPoint(x: uCP2.x, y: uCP2.y)
            let targetPoint = (i == numSegments - 1) ? endPoint : transformPoint(x: cos2, y: sin2)

            addCurve(CubicPoint(to: targetPoint, control1: cp1, control2: cp2))
        }
    }
}
