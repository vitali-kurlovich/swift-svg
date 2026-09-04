//
//  Created by Kurlovich Vitali on 8/14/26.
//

import CoreGraphics

public protocol DrawableType: Equatable, Sendable {
    init()
}

public struct DrawableUncknown: DrawableType, Equatable, Sendable { public init() {}}

public struct DrawableGroup: DrawableType, Equatable, Sendable { public init() {}}

public struct DrawableUse: DrawableType, Equatable, Sendable { public init() {}}

public struct DrawablePath: DrawableType, Equatable, Sendable { public init() {}}

public struct DrawableCircle: DrawableType, Equatable, Sendable { public init() {}}

public struct DrawableRect: DrawableType, Equatable, Sendable { public init() {}}

public extension Drawable {
    var isGroup: Bool {
        isTypeOf(DrawableGroup.self)
    }

    static func group(style: Style,
                      transform: CGAffineTransform? = nil,
                      childs: [Drawable] = []) -> Self
    {
        .init(DrawableGroup.self, style: style, transform: transform, childs: childs)
    }
}

public extension Drawable {
    var isPath: Bool {
        isTypeOf(DrawablePath.self)
    }

    static func path(style: Style,
                     transform: CGAffineTransform? = nil,
                     childs: [Drawable] = []) -> Self
    {
        .init(DrawablePath.self, style: style, transform: transform, childs: childs)
    }
}

// DrawableRect

public extension Drawable {
    var isRect: Bool {
        isTypeOf(DrawableRect.self)
    }

    static func rect(style: Style,
                     transform: CGAffineTransform? = nil,
                     childs: [Drawable] = []) -> Self
    {
        .init(DrawableRect.self, style: style, transform: transform, childs: childs)
    }
}

public extension Drawable {
    var isCircle: Bool {
        isTypeOf(DrawableCircle.self)
    }

    static func circle(style: Style,
                       transform: CGAffineTransform? = nil,
                       childs: [Drawable] = []) -> Self
    {
        .init(DrawableCircle.self, style: style, transform: transform, childs: childs)
    }
}

public extension Drawable {
    var isUse: Bool {
        isTypeOf(DrawableUse.self)
    }

    static func use(style: Style,
                    transform: CGAffineTransform? = nil,
                    childs: [Drawable] = []) -> Self
    {
        .init(DrawableUse.self, style: style, transform: transform, childs: childs)
    }
}
