//
//  Created by Kurlovich Vitali on 8/13/26.
//

public struct QuadraticVector: Sendable, Hashable {
    public var control1: Vector
    public var v: Vector

    @inlinable
    public init(control1: Vector, v: Vector) {
        self.control1 = control1
        self.v = v
    }
}
