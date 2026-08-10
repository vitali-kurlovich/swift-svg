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

        var keyValueIterator = SplitIterator(string: string, separator: ";")

        while let keyValue = keyValueIterator.next() {
            var iterator = SplitIterator(string: keyValue, separator: ":")

            if let key = iterator.next()?.trimmingCharacters(in: .whitespacesAndNewlines),
               key.isEmpty == false,
               let value = iterator.next()?.trimmingCharacters(in: .whitespacesAndNewlines),
               value.isEmpty == false
            {
                storage[key] = value
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
        storage[key]
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
