//
//  Created by Kurlovich Vitali on 9/2/26.
//

import struct CoreGraphics.CGFloat

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
        attributes["href"]
    }
}

public extension UseTag {
    var x: CGFloat {
        parseValue(key: "x")
    }

    var y: CGFloat {
        parseValue(key: "y")
    }

    var width: CGFloat {
        parseValue(key: "width")
    }

    var height: CGFloat {
        parseValue(key: "height")
    }
}

private extension UseTag {
    func parseValue(key: String, default value: CGFloat = 0) -> CGFloat {
        guard let string = attributes[key] else {
            return value
        }
        return CGFloat(Double(string) ?? value)
    }
}
