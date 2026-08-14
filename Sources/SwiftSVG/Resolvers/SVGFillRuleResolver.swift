//
//  Created by Kurlovich Vitali on 8/14/26.
//

public struct SVGFillRuleResolver {
    public init() {}

    public func rule(from string: some StringProtocol) -> Fill.Rule {
        switch string.trimmingCharacters(in: .whitespacesAndNewlines) {
        case "nonzero":
            .nonzero
        case "evenodd":
            .evenodd
        default:
            .default
        }
    }
}
