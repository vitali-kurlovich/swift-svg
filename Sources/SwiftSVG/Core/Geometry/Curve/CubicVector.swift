//
//  Created by Kurlovich Vitali on 8/13/26.
//

public struct CubicVector: Sendable, Hashable {
    public var control1: Vector
    public var control2: Vector
    public var v: Vector

    @inlinable
    public init(v1: Vector, v2: Vector, v: Vector) {
        control1 = v1
        control2 = v2
        self.v = v
    }
}
