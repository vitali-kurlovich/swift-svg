//
//  Created by Kurlovich Vitali on 8/10/26.
//

public struct SVGColorResolver {
    public init() {}

    public func color(from string: some StringProtocol) -> SolidColor? {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.hasPrefix("#") {
            return colorBy(hex: trimmed)
        } else if string.hasPrefix("rgb(") {
            return colorBy(rgb: trimmed)
        }
        return colorBy(name: trimmed)
    }
}

public extension SVGColorResolver {
    func colorBy(name: some StringProtocol) -> SolidColor? {
        namedColorsStorage[.init(name)]
    }

    func colorBy(hex: some StringProtocol) -> SolidColor? {
        guard hex.hasPrefix("#") else {
            return nil
        }

        let hex = hex.dropFirst()

        if hex.count == 3 {
            guard let red = UInt8(hex.dropLast(2), radix: 16) else {
                return nil
            }

            guard let green = UInt8(hex.dropFirst(1).dropLast(1), radix: 16) else {
                return nil
            }

            guard let blue = UInt8(hex.dropFirst(2), radix: 16) else {
                return nil
            }

            return SolidColor(red: (red << 4) | red,
                              green: (green << 4) | green,
                              blue: (blue << 4) | blue)
        }

        if hex.count == 6 {
            guard let uint32 = UInt32(hex, radix: 16) else {
                return nil
            }

            return SolidColor(uint32)
        }

        return nil
    }

    func colorBy(rgb: some StringProtocol) -> SolidColor? {
        guard rgb.hasPrefix("rgb("), rgb.hasSuffix(")") else {
            return nil
        }

        let components = rgb.dropFirst(4).dropLast(1)

        var iterator = components.split(characters: .svgNumbersSeparator).makeIterator()

        guard let r = iterator.next(), let red = parseColorComp(r),
              let g = iterator.next(), let green = parseColorComp(g),
              let b = iterator.next(), let blue = parseColorComp(b)
        else {
            return nil
        }

        guard let a = iterator.next(), let alpha = parseAlphaComp(a) else {
            return SolidColor(red: red, green: green, blue: blue)
        }

        return SolidColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

private extension SVGColorResolver {
    func parseColorComp(_ string: some StringProtocol) -> Float16? {
        if string.hasSuffix("%"), let value = Float16(string.dropLast(1)) {
            return value / 100.0
        }

        if let value = Float16(string) {
            return value / 255.0
        }

        return nil
    }

    func parseAlphaComp(_ string: some StringProtocol) -> Float16? {
        if string.hasSuffix("%"), let value = Float16(string.dropLast(1)) {
            return value / 100.0
        }

        if let value = Float16(string) {
            return value
        }

        return nil
    }
}

private let namedColorsStorage: [String: SolidColor] = [
    "black": .black, "silver": .silver, "gray": .gray, "white": .white, "maroon": .maroon, "red": .red, "purple": .purple, "fuchsia": .fuchsia, "green": .green, "lime": .lime, "olive": .olive, "yellow": .yellow, "navy": .navy, "blue": .blue, "teal": .teal, "aqua": .aqua, "aliceblue": .aliceblue, "antiquewhite": .antiquewhite, "aquamarine": .aquamarine, "azure": .azure, "beige": .beige, "bisque": .bisque, "blanchedalmond": .blanchedalmond, "blueviolet": .blueviolet, "brown": .brown, "burlywood": .burlywood, "cadetblue": .cadetblue, "chartreuse": .chartreuse, "chocolate": .chocolate, "coral": .coral, "cornflowerblue": .cornflowerblue, "cornsilk": .cornsilk, "crimson": .crimson, "cyan": .cyan, "darkblue": .darkblue, "darkcyan": .darkcyan, "darkgoldenrod": .darkgoldenrod, "darkgray": .darkgray, "darkgreen": .darkgreen, "darkgrey": .darkgrey, "darkkhaki": .darkkhaki, "darkmagenta": .darkmagenta, "darkolivegreen": .darkolivegreen, "darkorange": .darkorange, "darkorchid": .darkorchid, "darkred": .darkred, "darksalmon": .darksalmon, "darkseagreen": .darkseagreen, "darkslateblue": .darkslateblue, "darkslategray": .darkslategray, "darkslategrey": .darkslategrey, "darkturquoise": .darkturquoise, "darkviolet": .darkviolet, "deeppink": .deeppink, "deepskyblue": .deepskyblue, "dimgray": .dimgray, "dimgrey": .dimgrey, "dodgerblue": .dodgerblue, "firebrick": .firebrick, "floralwhite": .floralwhite, "forestgreen": .forestgreen, "gainsboro": .gainsboro, "ghostwhite": .ghostwhite, "gold": .gold, "goldenrod": .goldenrod, "greenyellow": .greenyellow, "grey": .grey, "honeydew": .honeydew, "hotpink": .hotpink, "indianred": .indianred, "indigo": .indigo, "ivory": .ivory, "khaki": .khaki, "lavender": .lavender, "lavenderblush": .lavenderblush, "lawngreen": .lawngreen, "lemonchiffon": .lemonchiffon, "lightblue": .lightblue, "lightcoral": .lightcoral, "lightcyan": .lightcyan, "lightgoldenrodyellow": .lightgoldenrodyellow, "lightgray": .lightgray, "lightgreen": .lightgreen, "lightgrey": .lightgrey, "lightpink": .lightpink, "lightsalmon": .lightsalmon, "lightseagreen": .lightseagreen, "lightskyblue": .lightskyblue, "lightslategray": .lightslategray, "lightslategrey": .lightslategrey, "lightsteelblue": .lightsteelblue, "lightyellow": .lightyellow, "limegreen": .limegreen, "linen": .linen, "magenta": .magenta, "mediumaquamarine": .mediumaquamarine, "mediumblue": .mediumblue, "mediumorchid": .mediumorchid, "mediumpurple": .mediumpurple, "mediumseagreen": .mediumseagreen, "mediumslateblue": .mediumslateblue, "mediumspringgreen": .mediumspringgreen, "mediumturquoise": .mediumturquoise, "mediumvioletred": .mediumvioletred, "midnightblue": .midnightblue, "mintcream": .mintcream, "mistyrose": .mistyrose, "moccasin": .moccasin, "navajowhite": .navajowhite, "oldlace": .oldlace, "olivedrab": .olivedrab, "orange": .orange, "orangered": .orangered, "orchid": .orchid, "palegoldenrod": .palegoldenrod, "palegreen": .palegreen, "paleturquoise": .paleturquoise, "palevioletred": .palevioletred, "papayawhip": .papayawhip, "peachpuff": .peachpuff, "peru": .peru, "pink": .pink, "plum": .plum, "powderblue": .powderblue, "rebeccapurple": .rebeccapurple, "rosybrown": .rosybrown, "royalblue": .royalblue, "saddlebrown": .saddlebrown, "salmon": .salmon, "sandybrown": .sandybrown, "seagreen": .seagreen, "seashell": .seashell, "sienna": .sienna, "skyblue": .skyblue, "slateblue": .slateblue, "slategray": .slategray, "slategrey": .slategrey, "snow": .snow, "springgreen": .springgreen, "steelblue": .steelblue, "tan": .tan, "thistle": .thistle, "tomato": .tomato, "transparent": .transparent, "turquoise": .turquoise, "violet": .violet, "wheat": .wheat, "whitesmoke": .whitesmoke, "yellowgreen": .yellowgreen,
]
