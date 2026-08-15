//
//  Created by Kurlovich Vitali on 8/15/26.
//

public struct SVGPathCommands: Sequence {
    public typealias Element = SVGPathCommand
    public typealias Iterator = SVGPathCommandIterator<String>

    public let d: String

    public init(_ string: String) {
        d = string
    }

    public func makeIterator() -> Iterator {
        Iterator(d)
    }
}
