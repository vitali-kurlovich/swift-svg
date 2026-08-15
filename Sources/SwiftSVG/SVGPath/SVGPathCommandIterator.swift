//
//  Created by Kurlovich Vitali on 8/4/26.
//

import struct Foundation.CharacterSet

public struct SVGPathCommandIterator<S: StringProtocol>: IteratorProtocol {
    public typealias Element = SVGPathCommand

    private var iterator: CommandIterator<S>

    init(_ string: S) {
        iterator = CommandIterator(string)
    }

    public mutating func next() -> SVGPathCommand? {
        guard let next = iterator.next() else {
            return nil
        }

        let argsCount = next.command.argsCount
        let count = argsCount > 0 ? next.arguments.count / argsCount : 0

        switch next.command {
        case .M:
            var iterator = next.makeIterator()

            guard let x: Double = iterator.nextDouble(),
                  let y: Double = iterator.nextDouble()
            else {
                assertionFailure("Move command requare 2 numbers")
                return nil
            }

            return .move(Point(x: x, y: y))

        case .m:
            var iterator = next.makeIterator()

            guard let dx = iterator.nextDouble(),
                  let dy = iterator.nextDouble()
            else {
                assertionFailure("Move command requare 2 numbers")
                return nil
            }

            return .moveRelative(Vector(dx: dx, dy: dy))

        case .L:
            var points: [Point] = []

            points.reserveCapacity(count)
            var iterator = next.makeIterator()

            while let x = iterator.nextDouble(),
                  let y = iterator.nextDouble()
            {
                points.append(Point(x: x, y: y))
            }

            return .line(points)

        case .l:
            var offsets: [Vector] = []
            offsets.reserveCapacity(count)
            var iterator = next.makeIterator()

            while let dx = iterator.nextDouble(),
                  let dy = iterator.nextDouble()
            {
                offsets.append(Vector(dx: dx, dy: dy))
            }

            return .lineRelative(offsets)

        case .H:
            var iterator = next.makeIterator()

            guard var x = iterator.nextDouble() else {
                assertionFailure("H command requare 1 numbers")
                return nil
            }

            while let value = iterator.nextDouble() {
                x = value
            }

            return .horizontal(HorizontalPoint(x: x))

        case .h:
            var iterator = next.makeIterator()

            guard var dx = iterator.nextDouble() else {
                assertionFailure("h command requare 1 numbers min")
                return nil
            }

            while let value = iterator.nextDouble() {
                dx = value
            }

            return .horizontalRelative(HorizontalVector(dx: dx))

        case .V:
            var iterator = next.makeIterator()

            guard var y = iterator.nextDouble() else {
                assertionFailure("V command requare 1 numbers min")
                return nil
            }

            while let value = iterator.nextDouble() {
                y = value
            }

            return .vertical(VerticalPoint(y: y))

        case .v:
            var iterator = next.makeIterator()

            guard var dy = iterator.nextDouble() else {
                assertionFailure("v command requare 1 numbers min")
                return nil
            }

            while let value = iterator.nextDouble() {
                dy = value
            }

            return .verticalRelative(VerticalVector(dy: dy))

        case .C:
            var points: [CubicPoint] = []
            points.reserveCapacity(count)

            var iterator = next.makeIterator()

            while let x1 = iterator.nextDouble(), let y1 = iterator.nextDouble(),
                  let x2 = iterator.nextDouble(), let y2 = iterator.nextDouble(),
                  let x = iterator.nextDouble(), let y = iterator.nextDouble()
            {
                let cp1 = Point(x: x1, y: y1)
                let cp2 = Point(x: x2, y: y2)
                let p = Point(x: x, y: y)

                points.append(CubicPoint(to: p, control1: cp1, control2: cp2))
            }

            return .cubic(points)

        case .c:
            var offsets: [CubicVector] = []
            offsets.reserveCapacity(count)

            var iterator = next.makeIterator()

            while let dx1 = iterator.nextDouble(), let dy1 = iterator.nextDouble(),
                  let dx2 = iterator.nextDouble(), let dy2 = iterator.nextDouble(),
                  let dx = iterator.nextDouble(), let dy = iterator.nextDouble()
            {
                let v1 = Vector(dx: dx1, dy: dy1)
                let v2 = Vector(dx: dx2, dy: dy2)
                let v = Vector(dx: dx, dy: dy)

                offsets.append(CubicVector(to: v, control1: v1, control2: v2))
            }

            return .cubicRelative(offsets)

        case .S:
            var points: [SmoothPoint] = []
            points.reserveCapacity(count)

            var iterator = next.makeIterator()

            while let x2 = iterator.nextDouble(), let y2 = iterator.nextDouble(),
                  let x = iterator.nextDouble(), let y = iterator.nextDouble()
            {
                let cp2 = Point(x: x2, y: y2)
                let p = Point(x: x, y: y)

                points.append(SmoothPoint(to: p, control2: cp2))
            }

            return .smooth(points)

        case .s:
            var offsets: [SmoothVector] = []
            offsets.reserveCapacity(count)

            var iterator = next.makeIterator()

            while let dx2 = iterator.nextDouble(), let dy2 = iterator.nextDouble(),
                  let dx = iterator.nextDouble(), let dy = iterator.nextDouble()
            {
                let cv2 = Vector(dx: dx2, dy: dy2)
                let v = Vector(dx: dx, dy: dy)

                offsets.append(SmoothVector(to: v, control2: cv2))
            }

            return .smoothRelative(offsets)

        case .Q:
            var points: [QuadraticPoint] = []
            points.reserveCapacity(count)

            var iterator = next.makeIterator()

            while let x1 = iterator.nextDouble(), let y1 = iterator.nextDouble(),
                  let x = iterator.nextDouble(), let y = iterator.nextDouble()
            {
                let cp1 = Point(x: x1, y: y1)
                let p = Point(x: x, y: y)

                points.append(QuadraticPoint(control1: cp1, p: p))
            }

            return .quadratic(points)

        case .q:
            var offsets: [QuadraticVector] = []
            offsets.reserveCapacity(count)

            var iterator = next.makeIterator()

            while let dx1 = iterator.nextDouble(), let dy1 = iterator.nextDouble(),
                  let dx = iterator.nextDouble(), let dy = iterator.nextDouble()
            {
                let cv1 = Vector(dx: dx1, dy: dy1)
                let v = Vector(dx: dx, dy: dy)

                offsets.append(QuadraticVector(to: v, control1: cv1))
            }

            return .quadraticRelative(offsets)

        case .T:
            var points: [Point] = []
            points.reserveCapacity(count)

            var iterator = next.makeIterator()

            while let x = iterator.nextDouble(), let y = iterator.nextDouble() {
                points.append(Point(x: x, y: y))
            }

            return .smoothQuadratic(points)

        case .t:
            var offsets: [Vector] = []
            offsets.reserveCapacity(count)

            var iterator = next.makeIterator()

            while let dx = iterator.nextDouble(), let dy = iterator.nextDouble() {
                offsets.append(Vector(dx: dx, dy: dy))
            }

            return .smoothQuadraticRelative(offsets)

        case .A:
            // (rx ry angle large-arc-flag sweep-flag x y)+

            var arcs: [ArcCurve] = []
            arcs.reserveCapacity(count)

            var iterator = next.makeIterator()

            while let rx = iterator.nextDouble(), let ry = iterator.nextDouble(),
                  let angle = iterator.nextDouble(),
                  let largeFlag = iterator.nextInt(), let sweep = iterator.nextInt(),
                  let x = iterator.nextDouble(), let y = iterator.nextDouble()
            {
                var options = ArcCurveOptions()

                if largeFlag != 0 {
                    options.insert(.drawLargerArc)
                }

                if sweep != 0 {
                    options.insert(.clockwise)
                }

                let arc = ArcCurve(
                    radius: .init(width: rx, height: ry),
                    end: .init(x: x, y: y),
                    angle: angle,
                    options: options,
                )

                arcs.append(arc)
            }

            return .arc(arcs)

        case .a:
            var arcs: [ArcOffsetCurve] = []
            arcs.reserveCapacity(count)

            var iterator = next.makeIterator()

            while let rx = iterator.nextDouble(), let ry = iterator.nextDouble(),
                  let angle = iterator.nextDouble(),
                  let largeFlag = iterator.nextInt(), let sweep = iterator.nextInt(),
                  let dx = iterator.nextDouble(), let dy = iterator.nextDouble()
            {
                var options = ArcCurveOptions()

                if largeFlag != 0 {
                    options.insert(.drawLargerArc)
                }

                if sweep != 0 {
                    options.insert(.clockwise)
                }

                let arc = ArcOffsetCurve(
                    radius: .init(width: rx, height: ry),
                    end: .init(dx: dx, dy: dy),
                    angle: angle,
                    options: options,
                )

                arcs.append(arc)
            }

            return .arcRelative(arcs)

        case .Z, .z:
            return .closePath
        }
    }
}
