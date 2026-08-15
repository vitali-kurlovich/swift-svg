//
//  Created by Kurlovich Vitali on 8/12/26.
//

public protocol SVGStylable: SVGElement {}

public extension SVGStylable {
    var fill: String? {
        attributes["fill"]
    }

    var `fill-opacity`: String? {
        attributes["fill-opacity"]
    }

    var `fill-rule`: String? {
        attributes["fill-rule"]
    }
}

public extension SVGStylable {
    var stroke: String? {
        attributes["stroke"]
    }

    var `stroke-opacity`: String? {
        attributes["stroke-opacity"]
    }

    var `stroke-width`: String? {
        attributes["stroke-width"]
    }

    var `stroke-linecap`: String? {
        attributes["stroke-linecap"]
    }

    var `stroke-linejoin`: String? {
        attributes["stroke-linejoin"]
    }

    var `stroke-miterlimit`: String? {
        attributes["stroke-miterlimit"]
    }

    var `stroke-dasharray`: String? {
        attributes["stroke-dasharray"]
    }

    var `stroke-dashoffset`: String? {
        attributes["stroke-dashoffset"]
    }
}

public extension SVGStylable {
    var style: SVGStyle {
        style([
            "fill", "fill-opacity", "fill-rule",
            "stroke", "stroke-opacity", "stroke-width", "stroke-linecap", "stroke-linejoin", "stroke-miterlimit",
            "stroke-dasharray", "stroke-dashoffset",
        ])
    }

    private func style(_ updateFields: [String]) -> SVGStyle {
        var style = SVGStyle(attributes["style"] ?? "")

        for name in updateFields {
            if style[name] == nil {
                style[name] = attributes[name]
            }
        }

        return style
    }
}
