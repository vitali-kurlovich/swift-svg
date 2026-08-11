//
//  Created by Kurlovich Vitali on 8/7/26.
//

public struct SVGMatrixAttribute: Sendable, Hashable {
    public let a: Double
    public let b: Double
    public let c: Double
    public let d: Double

    public let tx: Double
    public let ty: Double

    @inlinable
    public init(
        a: Double,
        b: Double,
        c: Double,
        d: Double,
        tx: Double,
        ty: Double,
    ) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.tx = tx
        self.ty = ty
    }
}

extension SVGMatrixAttribute {
    init?(_ string: some StringProtocol) {
        if string.hasPrefix("matrix(") {
            let mt = string.dropFirst("matrix(".count).dropLast()

            var iterator = mt.split(characters: .svgNumbersSeparator).makeIterator()

            let a = Double(iterator.next() ?? "1") ?? 1
            let b = Double(iterator.next() ?? "0") ?? 0
            let c = Double(iterator.next() ?? "0") ?? 0
            let d = Double(iterator.next() ?? "1") ?? 1

            let tx = Double(iterator.next() ?? "0") ?? 0
            let ty = Double(iterator.next() ?? "0") ?? 0

            self.init(a: a, b: b, c: c, d: d, tx: tx, ty: ty)

        } else {
            return nil
        }
    }
}
