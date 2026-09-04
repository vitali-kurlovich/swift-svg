//
//  Created by Kurlovich Vitali on 8/16/26.
//

import struct CoreGraphics.CGAffineTransform
import class CoreGraphics.CGContext
import class CoreGraphics.CGPath
import enum CoreGraphics.CGPathDrawingMode
import enum CoreGraphics.CGPathFillRule
import struct CoreGraphics.CGRect

public extension CGContext {
    func draw(
        _ drawable: Drawable,
        bounds: CGRect,
    ) {
        let render = DrawableRender(bounds: bounds, root: drawable)
        render.draw(context: self, drawable: drawable)
    }
}

private struct DrawableRender {
    let bounds: CGRect
    let root: Drawable
}

extension DrawableRender {
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

        if let rect = drawable[Rect.self] {
            let resolver = LengthUnitResolver(bounds: bounds)

            let (x, y) = resolver.resolve(x: rect.x, y: rect.y)
            let (width, height) = resolver.resolve(
                width: rect.width,
                height: rect.height,
            )
            let rx = resolver.resolve(rect.rx)
            let ry = resolver.resolve(rect.ry)

            let rect = CGRect(x: x, y: y, width: width, height: height)

            let path = if rx == 0, ry == 0 {
                CGPath(rect: rect, transform: nil)
            } else {
                CGPath(
                    roundedRect: rect,
                    cornerWidth: rx,
                    cornerHeight: ry,
                    transform: nil,
                )
            }

            draw(context: context, path: path, style: style)
        }

        if let circle = drawable[Circle.self] {
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

        if let ellipse = drawable[Ellipse.self] {
            let resolver = LengthUnitResolver(bounds: bounds)
            let (x, y) = resolver.resolve(x: ellipse.cx, y: ellipse.cy)
            let (rx, ry) = resolver.resolve(width: ellipse.rx, height: ellipse.ry)

            let rect = CGRect(
                x: x - rx,
                y: y - ry,
                width: 2 * rx,
                height: 2 * ry,
            )

            let path = CGPath(
                ellipseIn: rect,
                transform: nil,
            )
            draw(context: context, path: path, style: style)
        }

        if let use = drawable[Use.self] {
            if var refDrawable = root.find(by: use.href) {
                let resolver = LengthUnitResolver(bounds: bounds)
                let (x, y) = resolver.resolve(x: use.x, y: use.y)

                context.saveGState()
                let transform = CGAffineTransform(translationX: x, y: y)
                context.concatenate(transform)

                refDrawable.style = drawable.style
                draw(context: context, drawable: refDrawable)
                context.restoreGState()
            }
        }

        draw(context: context, drawables: drawable.childs)
    }

    private func draw(context: CGContext, drawables: [Drawable]) {
        for drawable in drawables {
            draw(context: context, drawable: drawable)
        }
    }
}

private extension DrawableRender {
    func draw(context: CGContext, path: CGPath, style: Style) {
        guard path.isEmpty == false, style.isСlear == false else { return }

        let fill = style.fill
        let stroke = style.stroke

        let mode: CGPathDrawingMode
        let rule = fill.rule

        context.setFill(fill)
        if let stroke {
            context.setStroke(stroke)
        }

        switch rule {
        case .nonzero:
            if fill.isСlear == false, stroke?.isСlear == false {
                mode = .fillStroke
            } else if fill.isСlear == false {
                mode = .fill

            } else {
                mode = .stroke
            }

        case .evenodd:
            if fill.isСlear == false, stroke?.isСlear == false {
                mode = .eoFillStroke
            } else if fill.isСlear == false {
                mode = .eoFill
            } else {
                mode = .stroke
            }
        }

        context.addPath(path)
        context.drawPath(using: mode)
    }
}
