//
//  Created by Kurlovich Vitali on 8/15/26.
//

import struct CoreGraphics.CGAffineTransform
import struct CoreGraphics.CGRect

public struct DrawableContainerFactory<Factory: DrawableFactory> {
    public let factory: Factory

    public init(factory: Factory) {
        self.factory = factory
    }

    public func drawable(from document: SvgDocument) -> DrawableContainer {
        drawable(from: document.svg)
    }
}

private extension DrawableContainerFactory {
    func drawable(from tag: SvgTag) -> DrawableContainer {
        .init(
            viewBox: tag.viewBox,
            drawable: drawable(with: tag, parentStyle: .default),
        )
    }

    func drawable(with tag: any SVGElement, parentStyle style: SVGStyle) -> Drawable {
        let style = tag.style.merging(style)
        let transform = tag.transform.map { CGAffineTransform($0) }

        let id = tag.id

        let childs = tag.childs.map {
            drawable(with: $0, parentStyle: style)
        }

        if let tag = tag as? PathTag {
            var dr = factory.pathDrawable(id: id,
                                          commands: tag.commands,
                                          style: .init(style),
                                          transform: transform)

            dr.childs = childs
            return dr
        }

        if let tag = tag as? CircleTag {
            var dr = factory.circleDrawable(id: id, Circle(cx: tag.cx, cy: tag.cy, r: tag.r), style: .init(style), transform: transform)
            dr.childs = childs
            return dr
        }

        if let tag = tag as? EllipseTag {
            var dr = factory.ellipseDrawable(id: id,
                                             Ellipse(cx: tag.cx, cy: tag.cy, rx: tag.rx, ry: tag.ry),
                                             style: .init(style),
                                             transform: transform)
            dr.childs = childs
            return dr
        }

        if tag is GTag {
            var dr = factory.groupDrawable(id: id, style: .init(style), transform: transform)
            dr.childs = childs
            return dr
        }

        if let tag = tag as? UseTag, let href = tag.href, href.isEmpty == false {
            var dr = factory.useDrawable(id: id,
                                         Use(href: href, x: tag.x, y: tag.y),
                                         style: .init(tag.style),
                                         transform: transform)
            dr.childs = childs
            return dr
        }

        return .init(
            type: DrawableUncknown(),
            style: .init(style),
            transform: transform,
            childs: childs,
        )
    }
}
