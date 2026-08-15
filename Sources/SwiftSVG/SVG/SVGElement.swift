//
//  Created by Kurlovich Vitali on 8/3/26.
//

public protocol SVGElement: Equatable, Sendable {
    static var name: String { get }

    var attributes: [String: String] { get }
    var childs: [any SVGElement] { get }
}

public extension SVGElement {
    var name: String {
        Self.name
    }
}

public extension SVGElement {
    static func == (lhs: Self, rhs: Self) -> Bool {
        isEquals(lhs: lhs, rhs: rhs)
    }
}

public protocol SVGMutableElement: SVGElement {
    var attributes: [String: String] { get set }
    var childs: [any SVGElement] { get set }
}

public extension SVGElement {
    static func isEquals(lhs: borrowing any SVGElement, rhs: borrowing any SVGElement) -> Bool {
        guard lhs.name == rhs.name, lhs.attributes == rhs.attributes else {
            return false
        }

        return isEquals(lhs: lhs.childs, rhs: rhs.childs)
    }

    static func isEquals(lhs: borrowing [any SVGElement], rhs: borrowing [any SVGElement]) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }

        for (left, right) in zip(lhs, rhs) {
            guard isEquals(lhs: left, rhs: right) else {
                return false
            }
        }

        return true
    }
}
