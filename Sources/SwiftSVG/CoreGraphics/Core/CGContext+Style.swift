//
//  Created by Kurlovich Vitali on 8/16/26.
//

import class CoreGraphics.CGColor
import class CoreGraphics.CGContext

public extension CGContext {
    func setOpacity(_ opacity: SolidOpacity) {
        setAlpha(.init(opacity.value))
    }
}

public extension CGContext {
    func setFill(_ fill: Fill) {
        setOpacity(fill.opacity)
        setFillShading(fill.shading)
    }

    func setFillShading(_ shading: Shading) {
        switch shading {
        case let .color(color):
            setFillColor(CGColor.color(from: color))
        }
    }
}

public extension CGContext {
    func setStroke(_ stroke: Stroke) {
        setOpacity(stroke.opacity)
        setFillShading(stroke.shading)
    }

    func setStrokeShading(_ shading: Shading) {
        switch shading {
        case let .color(color):
            setStrokeColor(CGColor.color(from: color))
        }
    }
}
