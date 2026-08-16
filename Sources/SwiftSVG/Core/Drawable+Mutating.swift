//
//  Created by Kurlovich Vitali on 8/16/26.
//

public extension Drawable {
    subscript<T: Equatable & Sendable>(_ type: T.Type) -> T? {
        get {
            let key = String(describing: type)
            return attributes[key] as? T
        }
        set {
            let key = String(describing: type)
            attributes[key] = newValue

            if newValue == nil {
                attributesKeys.remove(key)
            } else {
                attributesKeys.insert(key)
            }
        }
    }
}

public extension Drawable {
    mutating func updateAll<T: Equatable & Sendable>(
        key: T.Type,
        value: T?,
        where predicate: (Self) -> Bool,
    ) {
        if predicate(self) {
            self[key] = value
        }

        for index in childs.indices {
            childs[index].updateAll(key: key, value: value, where: predicate)
        }
    }

    mutating func updateFirst<T: Equatable & Sendable>(
        key: T.Type,
        value: T?,
        where predicate: (Self) -> Bool,
    ) -> Bool {
        if predicate(self) {
            self[key] = value
            return true
        }

        for index in childs.indices {
            if childs[index].updateFirst(key: key, value: value, where: predicate) {
                return true
            }
        }

        return false
    }
}
