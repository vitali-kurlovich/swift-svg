//
//  Created by Kurlovich Vitali on 8/14/26.
//

import Foundation

public struct Drawable<Transform: Equatable & Sendable>: Equatable, Sendable {
    public let type: String
    public var style: Style
    public var transform: Transform?

    public var attributes: [String: any(Equatable & Sendable)] = [:]
    public var childs: [Drawable<Transform>] = []

    public init(
        type: String,
        style: Style = .default,
        transform: Transform? = nil,
        childs: [Drawable<Transform>] = [],
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
    subscript<T: Equatable & Sendable>(_ type: T.Type) -> T? {
        get {
            let key = String(describing: type)
            return attributes[key] as? T
        }
        set {
            let key = String(describing: type)
            attributes[key] = newValue
        }
    }
}

public extension Drawable {
    init<T: Equatable & Sendable>(
        _: T.Type,
        style: Style = .default,
        transform: Transform? = nil,
        childs: [Drawable<Transform>] = [],
    ) {
        self.init(type: String(describing: T.self), style: style, transform: transform, childs: childs)
    }

    init<D: Equatable & Sendable>(
        _ data: D,
        style: Style = .default,
        transform: Transform? = nil,
        childs: [Drawable<Transform>] = [],
    ) {
        self.init(D.self, style: style, transform: transform, childs: childs)
        self[D.self] = data
    }

    func isTypeOf<T: Equatable>(_: T.Type) -> Bool {
        String(describing: T.self) == type
    }
}

extension Drawable {
    func isEqual(to other: Self) -> Bool {
        guard type == other.type,
              style == other.style,
              transform == other.transform,
              childs.count == other.childs.count,
              attributes.keys.count == other.attributes.keys.count
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
