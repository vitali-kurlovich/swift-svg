//
//  Created by Kurlovich Vitali on 8/15/26.
//

import SwiftUI

public struct DrawableView: View, Equatable {
    let viewBox: CGRect
    let drawable: Drawable<CGAffineTransform>

    public init(viewBox: CGRect, drawable: Drawable<CGAffineTransform>) {
        self.viewBox = viewBox
        self.drawable = drawable
    }

    public var body: some View {
        Canvas { context, size in
            let transform = CGAffineTransform
                .fit(from: viewBox, to: CGRect(origin: .zero, size: size))

            var context = context

            context.transform = transform
                .concatenating(context.transform)

            let render = CanvasRender(drawable: drawable)
            render.draw(context: context)

        }.frame(idealWidth: viewBox.width,
                idealHeight: viewBox.height)
    }
}

public extension DrawableView {
    init(_ container: DrawableContainer<CGAffineTransform, CGRect>) {
        self.init(viewBox: container.viewBox, drawable: container.drawable)
    }
}

extension FillStyle {
    init(_ rule: Fill.Rule, antialiased: Bool = true) {
        self.init(eoFill: rule == .evenodd, antialiased: antialiased)
    }
}

private struct CanvasRender {
    let drawable: Drawable<CGAffineTransform>

    func draw(context: GraphicsContext) {
        draw(context: context, drawable: drawable)
    }

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

#Preview {
    DrawableView(SVGMOCData.bunnyContainer).background {
        Color.white
    }
}
