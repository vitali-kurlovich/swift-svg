//
//  Created by Kurlovich Vitali on 8/16/26.
//

import struct CoreGraphics.CGAffineTransform
import class CoreGraphics.CGContext
import class CoreGraphics.CGPath
import enum CoreGraphics.CGPathFillRule
import struct CoreGraphics.CGRect

public extension CGContext {
    func draw(
        _ drawable: Drawable,
        bounds: CGRect,
    ) {
        let render = DrawableRender(bounds: bounds)
        render.draw(context: self, drawable: drawable)
    }
}

private struct DrawableRender {
    let bounds: CGRect
}

extension DrawableRender {
    func draw(context: CGContext, path: CGPath, style: Style) {
        context.addPath(path)

        let fill = style.fill

        if fill.isСlear == false {
            context.setFill(fill)
            context.fillPath(using: CGPathFillRule.rule(from: fill))
        }

        let stroke = style.stroke

        if stroke.isСlear == false {
            context.setStroke(stroke)
            context.strokePath()
        }
    }

    func draw(context: CGContext, drawable: Drawable) {
        let style = drawable.style

        if drawable.childs.isEmpty, style.isСlear {
            return
        }

        context.saveGState()
        defer {
            context.restoreGState()
        }

        if let transform = drawable.transform, transform.isIdentity == false {
            context.concatenate(transform)
        }

        if let path = drawable[CGPath.self] {
            draw(context: context, path: path, style: style)
        }

        if let circle = drawable[Circle.self] {
            print(circle)

            let resolver = LengthUnitResolver(bounds: bounds)

            let (x, y) = resolver.resolve(x: circle.cx, y: circle.cy)
            let r = resolver.resolve(circle.r)

            let rect = CGRect(
                x: x - r,
                y: y - r,
                width: 2 * r,
                height: 2 * r,
            )

            let path = CGPath(
                ellipseIn: rect,
                transform: nil,
            )
            draw(context: context, path: path, style: style)
        }

        draw(context: context, drawables: drawable.childs)
    }

    private func draw(context: CGContext, drawables: [Drawable]) {
        for drawable in drawables {
            draw(context: context, drawable: drawable)
        }
    }
}
