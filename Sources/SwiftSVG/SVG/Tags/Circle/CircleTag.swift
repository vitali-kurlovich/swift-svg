//
//  Created by Kurlovich Vitali on 9/3/26.
//

public struct CircleTag: SVGMutableElement {
    @inlinable
    public static var name: String {
        "circle"
    }

    public var attributes: [String: String] = [:]
    public var childs: [any SVGElement] = []

    init(attributes: [String: String] = [:], childs: [any SVGElement] = []) {
        self.attributes = attributes
        self.childs = childs
    }
}

public extension CircleTag {
    var cx: LengthUnit {
        parseValue(key: "cx")
    }

    var cy: LengthUnit {
        parseValue(key: "cy")
    }

    var r: LengthUnit {
        parseValue(key: "r")
    }
}

private extension CircleTag {
    func parseValue(key: String, default value: LengthUnit = .zero) -> LengthUnit {
        guard let string = attributes[key] else {
            return value
        }

        return SVGLengthUnitResolver().unit(from: string) ?? value
    }
}
