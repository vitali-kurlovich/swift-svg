//
//  Created by Kurlovich Vitali on 8/10/26.
//

import SwiftSVG
import Testing

struct SolidColorResolverTest {
    @Test
    func `color by name`() {
        let resolver = SVGColorResolver()

        #expect(resolver.colorBy(name: "red") == SolidColor(red: 1.0))
        #expect(resolver.colorBy(name: "blue") == SolidColor(blue: 1.0))
        #expect(resolver.colorBy(name: "lime") == SolidColor(green: 1.0))
    }

    @Test
    func `hex color`() {
        let resolver = SVGColorResolver()

        #expect(resolver.colorBy(hex: "#1A2B3C") == SolidColor(0x1A2B3C))
        #expect(resolver.colorBy(hex: "#ABC") == SolidColor(0xAABBCC))
    }

    @Test
    func `rgb()`() {
        let resolver = SVGColorResolver()
        #expect(
            resolver
                .colorBy(rgb: "rgb(12 54 88)") == SolidColor(
                    red: UInt8(12),
                    green: UInt8(54),
                    blue: UInt8(88),
                ),
        )

        #expect(
            resolver
                .colorBy(rgb: "rgb(12, 54, 88)") == SolidColor(
                    red: UInt8(12),
                    green: UInt8(54),
                    blue: UInt8(88),
                ),
        )

        #expect(
            resolver
                .colorBy(rgb: "rgb(25%, 50%, 75%)") == SolidColor(
                    red: 0.25,
                    green: 0.5,
                    blue: 0.75,
                ),
        )

        #expect(
            resolver
                .colorBy(rgb: "rgb(12 54 88 / 0.75)") == SolidColor(
                    red: UInt8(12),
                    green: UInt8(54),
                    blue: UInt8(88),
                    alpha: 0.75,
                ),
        )

        #expect(
            resolver
                .colorBy(rgb: "rgb(12 54 88 / 75%)") == SolidColor(
                    red: UInt8(12),
                    green: UInt8(54),
                    blue: UInt8(88),
                    alpha: 0.75,
                ),
        )
    }

    @Test
    func `from string`() {
        let resolver = SVGColorResolver()

        #expect(resolver.color(from: "lime") == SolidColor.lime)

        #expect(resolver.color(from: "#1A2B3C") == SolidColor(0x1A2B3C))

        #expect(
            resolver
                .color(from: "rgb(12 54 88 / 75%)") == SolidColor(
                    red: UInt8(12),
                    green: UInt8(54),
                    blue: UInt8(88),
                    alpha: 0.75,
                ),
        )
    }

    @Test
    func `incorrect format`() {
        let resolver = SVGColorResolver()
        #expect(resolver.colorBy(name: "$red") == nil)
        #expect(resolver.colorBy(name: "none") == nil)

        #expect(resolver.colorBy(hex: "1A2B3C") == nil)
        #expect(resolver.colorBy(hex: "$1A2B3C") == nil)

        #expect(resolver.colorBy(hex: "#1A2B3G") == nil)
        #expect(resolver.colorBy(hex: "#1A2B3CD") == nil)

        #expect(resolver.colorBy(hex: "ABC") == nil)
        #expect(resolver.colorBy(hex: "$ABC") == nil)

        #expect(resolver.colorBy(hex: "#GBC") == nil)
        #expect(resolver.colorBy(hex: "#AGC") == nil)
        #expect(resolver.colorBy(hex: "#ABG") == nil)

        #expect(resolver.colorBy(hex: "#ABCD") == nil)

        #expect(resolver.colorBy(rgb: "rgb(1, 2)") == nil)

        #expect(resolver.colorBy(rgb: "rgb (10 20 30)") == nil)

        #expect(resolver.colorBy(rgb: "rgb(10 20# 30)") == nil)

        #expect(resolver.colorBy(rgb: "rgb(20 30 40 / 0.5) ") == nil)
        #expect(resolver.colorBy(rgb: " rgb(20 30 40 / 0.5)") == nil)
    }
}
