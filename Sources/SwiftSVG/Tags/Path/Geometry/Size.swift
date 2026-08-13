//
//  Created by Kurlovich Vitali on 8/12/26.
//

public struct Size: Sendable, Hashable {
    public var width: Double
    public var height: Double

    @inlinable
    public init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}
