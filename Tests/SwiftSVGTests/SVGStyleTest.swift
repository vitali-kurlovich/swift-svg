//
//  Created by Kurlovich Vitali on 8/9/26.
//

@testable import SwiftSVG
import Testing

struct SVGStyleTest {
    @Test func empty() {
        #expect(SVGStyle("").isEmpty)

        #expect(SVGStyle("   ").isEmpty)

        #expect(SVGStyle("   : value ").isEmpty)

        #expect(SVGStyle("  key : ").isEmpty)
    }

    @Test func parse() {
        #expect(
            SVGStyle("fill-rule:evenodd") == SVGStyle(storage: ["fill-rule": "evenodd"]),
        )

        #expect(SVGStyle("fill-rule:evenodd").isEmpty == false)

        #expect(
            SVGStyle(" fill-rule   : evenodd  ") == SVGStyle(storage: ["fill-rule": "evenodd"]),
        )

        #expect(
            SVGStyle("fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;") ==
                SVGStyle(storage: [
                    "fill-rule": "evenodd",
                    "clip-rule": "evenodd",
                    "stroke-linejoin": "round",
                    "stroke-miterlimit": "2",

                ]),
        )

        #expect(
            SVGStyle(" fill-rule: evenodd  ;clip-rule  :evenodd;stroke-linejoin  : round          ;     stroke-miterlimit:2;") ==
                SVGStyle(storage: [
                    "fill-rule": "evenodd",
                    "clip-rule": "evenodd",
                    "stroke-linejoin": "round",
                    "stroke-miterlimit": "2",

                ]),
        )
    }

    @Test
    func value() {
        let style = SVGStyle(" fill-rule: evenodd  ;clip-rule  :evenodd;stroke-linejoin  : round;stroke-miterlimit:2;")

        #expect(style["fill-rule"] == "evenodd")
        #expect(style["clip-rule"] == "evenodd")
        #expect(style["stroke-linejoin"] == "round")
        #expect(style["stroke-miterlimit"] == "2")
    }

    @Test func merge() {
        var style = SVGStyle(" fill-rule: evenodd  ;clip-rule  :evenodd;stroke-linejoin  : round;")

        let second = SVGStyle(" fill-rule: evenodd  ;clip-rule  :nonzero; stroke-miterlimit:2;")

        #expect(
            style.merging(second) == SVGStyle("fill-rule:evenodd;clip-rule:nonzero;stroke-linejoin:round;stroke-miterlimit:2;"),
        )

        #expect(
            style == SVGStyle(" fill-rule: evenodd  ;clip-rule  :evenodd;stroke-linejoin  : round;"),
        )

        style.merge(second)

        #expect(
            style == SVGStyle("fill-rule:evenodd;clip-rule:nonzero;stroke-linejoin:round;stroke-miterlimit:2;"),
        )
    }
}
