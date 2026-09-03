//
//  Created by Kurlovich Vitali on 9/2/26.
//

public struct DefsTag: SVGMutableElement {
    @inlinable
    public static var name: String {
        "defs"
    }

    public var attributes: [String: String] = [:]
    public var childs: [any SVGElement] = []

    init(attributes: [String: String] = [:], childs: [any SVGElement] = []) {
        self.attributes = attributes
        self.childs = childs
    }
}
