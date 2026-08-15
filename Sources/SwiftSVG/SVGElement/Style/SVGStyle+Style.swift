//
//  Created by Kurlovich Vitali on 8/14/26.
//

public extension Style {
    init(_ svg: SVGStyle) {
        self.init(fill: .init(svg), stroke: .init(svg))
    }
}

public extension Stroke {
    init(_ svg: SVGStyle) {
        self.init(
            opacity: svg.strokeOpacity,
            shading: svg.stroke,
            linecap: svg.strokeLinecap,
            lineJoin: svg.strokeLineJoin,
            miterLimit: svg.strokeMiterLimit,
            width: svg.strokeWidth,
            dashArray: svg.strokeDashArray,
            dashOffset: svg.strokeDashOffset,
        )
    }
}

public extension Fill {
    init(_ svg: SVGStyle) {
        self.init(opacity: svg.fillOpacity, shading: svg.fill, rule: svg.fillRule)
    }
}

public extension SVGStyle {
    var fill: Shading {
        let resolver = SVGColorResolver()

        guard let fill = self["fill"], let color = resolver.color(from: fill) else {
            return .default
        }

        return .color(color)
    }

    var fillOpacity: Fill.Opacity {
        let resolver = SVGOpacityResolver()

        guard let opacity = self["fill-opacity"],
              let opacity = resolver.opacity(from: opacity)
        else {
            return .default
        }

        return opacity
    }

    var fillRule: Fill.Rule {
        guard let rule = self["fill-rule"] else {
            return .default
        }
        let resolver = SVGFillRuleResolver()

        return resolver.rule(from: rule)
    }
}

public extension SVGStyle {
    var stroke: Shading {
        let resolver = SVGColorResolver()

        guard let stroke = self["stroke"], let color = resolver.color(from: stroke) else {
            return .default
        }

        return .color(color)
    }

    var strokeOpacity: Stroke.Opacity {
        let resolver = SVGOpacityResolver()

        guard let opacity = self["stroke-opacity"],
              let opacity = resolver.opacity(from: opacity)
        else {
            return .default
        }

        return opacity
    }

    var strokeWidth: Stroke.Width {
        let resolver = SVGLengthUnitResolver()

        guard let width = self["stroke-width"], let width = resolver.unit(from: width) else {
            return .default
        }

        return Stroke.Width(width)
    }

    var strokeLinecap: Stroke.LineCap {
        guard let linecap = self["stroke-linecap"] else {
            return .default
        }

        let resolver = SVGLineCapResolver()

        return resolver.lineCap(from: linecap)
    }

    var strokeLineJoin: Stroke.LineJoin {
        guard let linejoin = self["stroke-linejoin"] else {
            return .default
        }

        let resolver = SVGLineJoinResolver()

        return resolver.lineJoin(from: linejoin)
    }

    var strokeMiterLimit: Stroke.MiterLimit {
        guard let miterlimit = self["stroke-miterlimit"],
              let miterlimit = Float32(miterlimit)
        else {
            return .default
        }

        return Stroke.MiterLimit(value: miterlimit)
    }

    var strokeDashArray: Stroke.DashArray {
        guard let dasharray = self["stroke-dasharray"] else {
            return .default
        }

        let resolver = SVGDashArrayResolver()
        return resolver.dashArray(from: dasharray)
    }

    var strokeDashOffset: Stroke.DashOffset {
        let resolver = SVGLengthUnitResolver()

        guard let offset = self["stroke-dashoffset"], let offset = resolver.unit(from: offset) else {
            return .default
        }

        return Stroke.DashOffset(offset: offset)
    }
}
