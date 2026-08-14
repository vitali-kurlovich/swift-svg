
//
//  Created by Kurlovich Vitali on 8/15/26.
//

import SwiftUI

public extension DrawableContainer where Transform == CGAffineTransform, Rect == CGRect {
    init(_ document: SvgDocument) {
        self.init(document.svg)
    }

    init(_ tag: SvgTag) {
        self.init(
            viewBox: tag.viewBox,
            drawable: .drawable(with: tag, parentStyle: .default),
        )
    }
}

extension Drawable where Transform == CGAffineTransform {
    static func drawable(with tag: any SVGStylable, parentStyle style: SVGStyle) -> Self {
        if let tag = tag as? PathTag {
            return drawable(with: tag, parentStyle: style)
        }

        if let tag = tag as? GTag {
            return drawable(with: tag, parentStyle: style)
        }

        if let tag = tag as? SvgTag {
            return drawable(with: tag, parentStyle: style)
        }

        let style = tag.style.merging(style)

        let transform = tag.transform.map { CGAffineTransform($0) }

        let childs = tag.childs.isEmpty ? [] : drawables(
            with: tag.childs,
            parentStyle: style,
        )

        return .init(
            type: tag.name,
            style: .init(style),
            transform: transform,
            childs: childs,
        )
    }

    static func drawables(with tags: [any SVGElement], parentStyle style: SVGStyle) -> [Self] {
        tags.compactMap {
            if let tag = $0 as? any SVGStylable {
                return Self.drawable(with: tag, parentStyle: style)
            }
            return nil
        }
    }

    static func drawable(with tag: SvgTag, parentStyle style: SVGStyle) -> Self {
        let style = tag.style.merging(style)

        let transform = tag.transform.map { CGAffineTransform($0) }

        let childs = tag.childs.isEmpty ? [] : drawables(
            with: tag.childs,
            parentStyle: style,
        )

        return .init(type: "svg", style: .init(style), transform: transform, childs: childs)
    }

    static func drawable(with tag: GTag, parentStyle style: SVGStyle) -> Self {
        let style = tag.style.merging(style)

        let transform = tag.transform.map { CGAffineTransform($0) }

        let childs = tag.childs.isEmpty ? [] : drawables(
            with: tag.childs,
            parentStyle: style,
        )

        return Self.group(style: .init(style), transform: transform, childs: childs)
    }

    static func drawable(with tag: PathTag, parentStyle style: SVGStyle) -> Self {
        let style = tag.style.merging(style)

        let transform = tag.transform.map { CGAffineTransform($0) }

        let childs = tag.childs.isEmpty ? [] : drawables(
            with: tag.childs,
            parentStyle: style,
        )

        let path = Path(tag.commands)

        return .init(path, style: .init(style), transform: transform, childs: childs)
    }
}
