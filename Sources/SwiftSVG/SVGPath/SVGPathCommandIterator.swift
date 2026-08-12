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
            var iterator = next.arguments.makeIterator()

            guard let x = iterator.next(), let y = iterator.next() else {
                assertionFailure("Move command requare 2 numbers")
                return nil
            }

            return .move(Point(x: x, y: y))

        case .m:
            var iterator = next.arguments.makeIterator()

            guard let dx = iterator.next(), let dy = iterator.next() else {
                assertionFailure("Move command requare 2 numbers")
                return nil
            }

            return .moveRelative(Vector(dx: dx, dy: dy))

        case .L:
            var points: [Point] = []

            points.reserveCapacity(count)
            var iterator = next.arguments.makeIterator()

            while let x = iterator.next(), let y = iterator.next() {
                points.append(Point(x: x, y: y))
            }

            return .line(points)

        case .l:
            var offsets: [Vector] = []
            offsets.reserveCapacity(count)
            var iterator = next.arguments.makeIterator()

            while let dx = iterator.next(), let dy = iterator.next() {
                offsets.append(Vector(dx: dx, dy: dy))
            }

            return .lineRelative(offsets)

        case .H:
            var iterator = next.arguments.makeIterator()

            guard var x = iterator.next() else {
                assertionFailure("H command requare 1 numbers")
                return nil
            }

            while let value = iterator.next() {
                x = value
            }

            return .horizontal(HorizontalPoint(x: x))

        case .h:
            var iterator = next.arguments.makeIterator()

            guard var dx = iterator.next() else {
                assertionFailure("h command requare 1 numbers min")
                return nil
            }

            while let value = iterator.next() {
                dx = value
            }

            return .horizontalRelative(HorizontalVector(dx: dx))

        case .V:
            var iterator = next.arguments.makeIterator()

            guard var y = iterator.next() else {
                assertionFailure("V command requare 1 numbers min")
                return nil
            }

            while let value = iterator.next() {
                y = value
            }

            return .vertical(VerticalPoint(y: y))

        case .v:
            var iterator = next.arguments.makeIterator()

            guard var dy = iterator.next() else {
                assertionFailure("v command requare 1 numbers min")
                return nil
            }

            while let value = iterator.next() {
                dy = value
            }

            return .verticalRelative(VerticalVector(dy: dy))

        case .C:
            var points: [CubicPoint] = []
            points.reserveCapacity(count)

            var iterator = next.arguments.makeIterator()

            while let x1 = iterator.next(), let y1 = iterator.next(),
                  let x2 = iterator.next(), let y2 = iterator.next(),
                  let x = iterator.next(), let y = iterator.next()
            {
                let p1 = Point(x: x1, y: y1)
                let p2 = Point(x: x2, y: y2)
                let p = Point(x: x, y: y)

                points.append(CubicPoint(p1: p1, p2: p2, p: p))
            }

            return .cubic(points)

        case .c:
            var offsets: [CubicVector] = []
            offsets.reserveCapacity(count)

            var iterator = next.arguments.makeIterator()

            while let dx1 = iterator.next(), let dy1 = iterator.next(),
                  let dx2 = iterator.next(), let dy2 = iterator.next(),
                  let dx = iterator.next(), let dy = iterator.next()
            {
                let v1 = Vector(dx: dx1, dy: dy1)
                let v2 = Vector(dx: dx2, dy: dy2)
                let v = Vector(dx: dx, dy: dy)

                offsets.append(CubicVector(v1: v1, v2: v2, v: v))
            }

            return .cubicRelative(offsets)

        case .S:
            var points: [SmoothPoint] = []
            points.reserveCapacity(count)

            var iterator = next.arguments.makeIterator()

            while let x2 = iterator.next(), let y2 = iterator.next(),
                  let x = iterator.next(), let y = iterator.next()
            {
                let p2 = Point(x: x2, y: y2)
                let p = Point(x: x, y: y)

                points.append(SmoothPoint(p2: p2, p: p))
            }

            return .smooth(points)

        case .s:
            var offsets: [SmoothVector] = []
            offsets.reserveCapacity(count)

            var iterator = next.arguments.makeIterator()

            while let dx2 = iterator.next(), let dy2 = iterator.next(),
                  let dx = iterator.next(), let dy = iterator.next()
            {
                let v2 = Vector(dx: dx2, dy: dy2)
                let v = Vector(dx: dx, dy: dy)

                offsets.append(SmoothVector(v2: v2, v: v))
            }

            return .smoothRelative(offsets)

        case .Q:
            var points: [QuadraticPoint] = []
            points.reserveCapacity(count)

            var iterator = next.arguments.makeIterator()

            while let x1 = iterator.next(), let y1 = iterator.next(),
                  let x = iterator.next(), let y = iterator.next()
            {
                let p1 = Point(x: x1, y: y1)
                let p = Point(x: x, y: y)

                points.append(QuadraticPoint(p1: p1, p: p))
            }

            return .quadratic(points)

        case .q:
            var offsets: [QuadraticVector] = []
            offsets.reserveCapacity(count)

            var iterator = next.arguments.makeIterator()

            while let dx1 = iterator.next(), let dy1 = iterator.next(),
                  let dx = iterator.next(), let dy = iterator.next()
            {
                let v1 = Vector(dx: dx1, dy: dy1)
                let v = Vector(dx: dx, dy: dy)

                offsets.append(QuadraticVector(v1: v1, v: v))
            }

            return .quadraticRelative(offsets)

        case .T:
            var points: [Point] = []
            points.reserveCapacity(count)

            var iterator = next.arguments.makeIterator()

            while let x = iterator.next(), let y = iterator.next() {
                points.append(Point(x: x, y: y))
            }

            return .smoothQuadratic(points)

        case .t:
            var offsets: [Vector] = []
            offsets.reserveCapacity(count)

            var iterator = next.arguments.makeIterator()

            while let dx = iterator.next(), let dy = iterator.next() {
                offsets.append(Vector(dx: dx, dy: dy))
            }

            return .smoothQuadraticRelative(offsets)

        case .A, .a:
            return self.next()

        case .Z, .z:
            return .closePath
        }
    }
}
