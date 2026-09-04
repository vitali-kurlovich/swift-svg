//
//  Created by Kurlovich Vitali on 8/14/26.
//

import CoreGraphics

public struct Drawable: Equatable, Sendable {
    public let type: any DrawableType
    public var style: Style
    public var transform: CGAffineTransform?
    public var childs: [Drawable] = []

    var attributes: [String: any(Equatable & Sendable)] = [:]
    var attributesKeys: Set<String> = []

    public init(
        type: any DrawableType,
        style: Style,
        transform: CGAffineTransform? = nil,
        childs: [Drawable] = [],
    ) {
        self.type = type
        self.style = style
        self.transform = transform
        self.childs = childs
    }

    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs.isEqual(to: rhs)
    }
}

public extension Drawable {
    var id: String? {
        attributes["id"] as? String
    }
}

public extension Drawable {
    func find(by id: String) -> Drawable? {
        if self.id == id {
            return self
        }

        for child in childs {
            if let drawable = child.find(by: id) {
                return drawable
            }
        }

        return nil
    }
}

public extension Drawable {
    init<T: DrawableType>(
        _: T.Type,
        style: Style,
        transform: CGAffineTransform? = nil,
        childs: [Drawable] = [],
    ) {
        self.init(type: T(), style: style, transform: transform, childs: childs)
    }

    func isTypeOf<T: Equatable>(_: T.Type) -> Bool {
        type is T
    }
}

extension Drawable {
    func isEqual(to other: Self) -> Bool {
        guard
            attributesKeys == other.attributesKeys,
            style == other.style,
            transform == other.transform,
            childs.count == other.childs.count,
            type.isEqual(other.type)
        else {
            return false
        }

        for (key, value) in attributes {
            guard let otherValue = other.attributes[key], value.isEqual(otherValue) else {
                return false
            }
        }

        for (child, otherChild) in zip(childs, other.childs) {
            guard child.isEqual(to: otherChild) else {
                return false
            }
        }

        return true
    }
}

extension Equatable {
    func isEqual(_ other: any Equatable) -> Bool {
        guard let other = other as? Self else {
            return other.isExactlyEqual(self)
        }
        return self == other
    }

    private func isExactlyEqual(_ other: any Equatable) -> Bool {
        guard let other = other as? Self else {
            return false
        }
        return self == other
    }
}
