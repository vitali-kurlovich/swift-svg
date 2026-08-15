//
//  Created by Kurlovich Vitali on 8/15/26.
//

public struct SVGPathCommands<S: StringProtocol>: Sequence {
    public typealias Element = PathCommand
    public typealias Iterator = SVGPathCommandsAdapter<S>

    public let d: S

    public init(_ string: S) {
        d = string
    }

    public func makeIterator() -> Iterator {
        Iterator(d)
    }
}
