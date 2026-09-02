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

    func drawable(from document: SvgDocument) -> DrawableContainer {
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

        let childs = tag.childs.map {
            drawable(with: $0, parentStyle: style)
        }

        if let tag = tag as? PathTag {
            var dr = factory.pathDrawable(
                commands: tag.commands,
                style: .init(style),
                transform: transform,
            )

            dr.childs = childs
            return dr
        }

        if tag is GTag {
            var dr = factory.groupDrawable(style: .init(style), transform: transform)
            dr.childs = childs
            return dr
        }

        return .init(
            type: tag.name,
            style: .init(style),
            transform: transform,
            childs: childs,
        )
    }
}
