//
//  Created by Kurlovich Vitali on 8/9/26.
//

public struct SVGStyle: Hashable, Sendable {
    @usableFromInline
    var storage: [String: String]
}

public extension SVGStyle {
    init(_ string: String) {
        var storage: [String: String] = [:]

        var iterator = string.split(character: ";").makeIterator()

        while let keyValue = iterator.next() {
            var iterator = keyValue.split(characters: .keyValueSeparator).makeIterator()

            if let key = iterator.next(), let value = iterator.next() {
                storage[String(key)] = String(value)
            }
        }
        self.init(storage: storage)
    }
}

extension SVGStyle: Collection {
    public typealias Element = Dictionary<String, String>.Element
    public typealias Index = Dictionary<String, String>.Index

    @inlinable
    public var isEmpty: Bool {
        storage.isEmpty
    }

    @inlinable
    public func index(after i: Index) -> Index {
        storage.index(after: i)
    }

    @inlinable
    public subscript(position: Index) -> Element {
        storage[position]
    }

    @inlinable
    public var startIndex: Index {
        storage.startIndex
    }

    @inlinable
    public var endIndex: Index {
        storage.endIndex
    }
}

public extension SVGStyle {
    @inlinable
    subscript(key: String) -> String? {
        get {
            storage[key]
        }
        set {
            storage[key] = newValue
        }
    }
}

public extension SVGStyle {
    mutating func merge(_ style: SVGStyle) {
        storage.merge(style.storage) { _, new in
            new
        }
    }

    func merging(_ style: SVGStyle) -> SVGStyle {
        let newStorage = storage.merging(style.storage) { _, new in
            new
        }

        return SVGStyle(storage: newStorage)
    }
}
