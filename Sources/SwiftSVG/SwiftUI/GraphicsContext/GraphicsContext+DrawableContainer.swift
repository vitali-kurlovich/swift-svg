//
//  Created by Kurlovich Vitali on 8/16/26.
//

import struct CoreGraphics.CGAffineTransform
import struct CoreGraphics.CGRect
import struct CoreGraphics.CGSize
import struct SwiftUI.FillStyle
import struct SwiftUI.GraphicsContext
import struct SwiftUI.Path

public extension GraphicsContext {
    func draw(_ drawable: Drawable<CGAffineTransform>) {
        let render = DrawableRender(drawable: drawable)
        render.draw(context: self)
    }
}

private struct DrawableRender {
    let drawable: Drawable<CGAffineTransform>

    func draw(context: GraphicsContext) {
        draw(context: context, drawable: drawable)
    }
}

private extension DrawableRender {
    func draw(context: GraphicsContext, drawable: Drawable<CGAffineTransform>) {
        var context = context

        if let transform = drawable.transform, transform.isIdentity == false {
            context.transform = transform
                .concatenating(context.transform)
        }

        let opacity = context.opacity

        if let path = drawable[Path.self] {
            let style = drawable.style

            context.opacity = .init(style.fill.opacity.value)
            context
                .fill(
                    path,
                    with: .init(style.fill.shading),
                    style: FillStyle(style.fill.rule),
                )

            context.opacity = .init(style.stroke.opacity.value)

            // context.stroke(path, with: .color(.white))
        }

        context.opacity = opacity

        draw(context: context, drawables: drawable.childs)
    }

    func draw(context: GraphicsContext, drawables: [Drawable<CGAffineTransform>]) {
        for drawable in drawables {
            draw(context: context, drawable: drawable)
        }
    }
}
