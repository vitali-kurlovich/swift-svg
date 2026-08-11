//
//  Created by Kurlovich Vitali on 8/11/26.
//

import struct Foundation.CharacterSet

extension CharacterSet {
    static let svgDecimalDigitsAndFraction = CharacterSet.decimalDigits.union(
        CharacterSet(charactersIn: "-."),
    )

    static let svgNumbersSeparator = CharacterSet.whitespacesAndNewlines.union(
        CharacterSet(charactersIn: ",/"),
    )

    static let decimalDigitsAndFractionSeparator = CharacterSet.decimalDigits.union(
        CharacterSet(charactersIn: "-."),
    )

    static let whitespacesNewlinesAndCommma = CharacterSet.whitespacesAndNewlines.union(
        CharacterSet(charactersIn: ","),
    )

    static let svgCommands = CharacterSet(charactersIn: "MmLlHhVvCcSsQqTtAaZz")

    static let keyValueSeparator = CharacterSet.whitespacesAndNewlines.union(
        CharacterSet(charactersIn: ":"),
    )
}
