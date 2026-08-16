//
//  Created by Kurlovich Vitali on 8/16/26.
//

import struct CoreGraphics.CGAffineTransform
import class CoreGraphics.CGContext
import class CoreGraphics.CGPath
import enum CoreGraphics.CGPathFillRule

public extension CGContext {
    func draw(
        _ drawable: Drawable<CGAffineTransform>,
    ) {
        let render = DrawableRender()
        render.draw(context: self, drawable: drawable)
    }
}

private struct DrawableRender {}

extension DrawableRender {
    func draw(context: CGContext, drawable: Drawable<CGAffineTransform>) {
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

        draw(context: context, drawables: drawable.childs)
    }

    private func draw(context: CGContext, drawables: [Drawable<CGAffineTransform>]) {
        for drawable in drawables {
            draw(context: context, drawable: drawable)
        }
    }
}
