//
//  Created by Kurlovich Vitali on 8/14/26.
//

import Foundation

public struct Drawable<Transform: Equatable>: Equatable {
    public let type: String
    public var style: Style
    public var transform: Transform?

    public var attributes: [String: any Equatable] = [:]
    public var childs: [Drawable<Transform>] = []

    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs.isEqual(to: rhs)
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
