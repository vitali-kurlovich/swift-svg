//
//  Created by Kurlovich Vitali on 9/2/26.
//

public struct UseTag: SVGMutableElement {
    @inlinable
    public static var name: String {
        "use"
    }

    public var attributes: [String: String] = [:]
    public var childs: [any SVGElement] = []

    init(attributes: [String: String] = [:], childs: [any SVGElement] = []) {
        self.attributes = attributes
        self.childs = childs
    }
}

public extension UseTag {
    var href: String? {
        guard let href = attributes["href"] else {
            return nil
        }

        return String(href.dropFirst())
    }
}

public extension UseTag {
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
}

private extension UseTag {
    func parseValue(key: String, default value: LengthUnit = .zero) -> LengthUnit {
        guard let string = attributes[key] else {
            return value
        }

        return SVGLengthUnitResolver().unit(from: string) ?? value
    }
}
