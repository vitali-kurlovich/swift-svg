//
//  Created by Kurlovich Vitali on 8/13/26.
//

public struct CubicVector: Sendable, Hashable {
    public var target: Vector
    public var control1: Vector
    public var control2: Vector

    @inlinable
    public init(to target: Vector, control1: Vector, control2: Vector) {
        self.target = target
        self.control1 = control1
        self.control2 = control2
    }
}
