//
//  Created by Kurlovich Vitali on 9/4/26.
//

public struct RectTag: SVGMutableElement {
    @inlinable
    public static var name: String {
        "rect"
    }

    public var attributes: [String: String] = [:]
    public var childs: [any SVGElement] = []

    init(attributes: [String: String] = [:], childs: [any SVGElement] = []) {
        self.attributes = attributes
        self.childs = childs
    }
}

public extension RectTag {
    var x: LengthUnit {
        parseValue(key: "x")
    }

    var y: LengthUnit {
        parseValue(key: "y")
    }

    var width: LengthUnit {
        parseValue(key: "width")
    }

    var height: LengthUnit {
        parseValue(key: "height")
    }

    var rx: LengthUnit {
        parseValueWithNil(key: "rx") ?? parseValueWithNil(key: "ry") ?? .zero
    }

    var ry: LengthUnit {
        parseValueWithNil(key: "ry") ?? parseValueWithNil(key: "rx") ?? .zero
    }
}

private extension RectTag {
    func parseValueWithNil(key: String) -> LengthUnit? {
        guard let string = attributes[key] else {
            return nil
        }

        return SVGLengthUnitResolver().unit(from: string)
    }

    func parseValue(key: String, default value: LengthUnit = .zero) -> LengthUnit {
        guard let string = attributes[key] else {
            return value
        }

        return SVGLengthUnitResolver().unit(from: string) ?? value
    }
}
