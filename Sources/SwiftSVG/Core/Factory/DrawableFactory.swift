//
//  Created by Kurlovich Vitali on 8/15/26.
//

import CoreGraphics

public protocol DrawableFactory {
    func groupDrawable(id: String?, style: Style, transform: CGAffineTransform?) -> Drawable

    func useDrawable(id: String?, _ use: Use, style: Style, transform: CGAffineTransform?) -> Drawable

    func pathDrawable(id: String?, commands: some Sequence<PathCommand>, style: Style, transform: CGAffineTransform?) -> Drawable

    func circleDrawable(id: String?, _ circle: Circle, style: Style, transform: CGAffineTransform?) -> Drawable
    func ellipseDrawable(id: String?, _ ellipse: Ellipse, style: Style, transform: CGAffineTransform?) -> Drawable
}

public extension DrawableFactory {
    func groupDrawable(id: String?, style: Style, transform: CGAffineTransform?) -> Drawable {
        var group = Drawable.group(style: style, transform: transform)
        group.attributes["id"] = id
        return group
    }
}
