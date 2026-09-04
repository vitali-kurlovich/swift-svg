//
//  Created by Kurlovich Vitali on 9/3/26.
//

import struct CoreGraphics.CGFloat

public struct EllipseTag: SVGMutableElement {
    @inlinable
    public static var name: String {
        "ellipse"
    }

    public var attributes: [String: String] = [:]
    public var childs: [any SVGElement] = []

    init(attributes: [String: String] = [:], childs: [any SVGElement] = []) {
        self.attributes = attributes
        self.childs = childs
    }
}

public extension EllipseTag {
    var cx: LengthUnit {
        parseValue(key: "cx")
    }

    var cy: LengthUnit {
        parseValue(key: "cy")
    }

    var rx: LengthUnit {
        parseValue(key: "rx")
    }

    var ry: LengthUnit {
        parseValue(key: "ry")
    }

    var pathLength: CGFloat? {
        guard let string = attributes["pathLength"], let value = Double(string) else {
            return nil
        }
        return CGFloat(value)
    }
}

private extension EllipseTag {
    func parseValue(key: String, default value: LengthUnit = .zero) -> LengthUnit {
        guard let string = attributes[key] else {
            return value
        }

        return SVGLengthUnitResolver().unit(from: string) ?? value
    }
}
