//
//  Created by Kurlovich Vitali on 8/10/26.
//

import SwiftSVG
import Testing

struct SolidColorResolverTest {
    @Test
    func `color by name`() {
        let resolver = SolidColorResolver()

        #expect(resolver.colorBy(name: "red") == SolidColor(red: 1.0))
        #expect(resolver.colorBy(name: "blue") == SolidColor(blue: 1.0))
        #expect(resolver.colorBy(name: "lime") == SolidColor(green: 1.0))
    }

    @Test
    func `hex color`() {
        let resolver = SolidColorResolver()

        #expect(resolver.colorBy(hex: "#1A2B3C") == SolidColor(0x1A2B3C))
        #expect(resolver.colorBy(hex: "#ABC") == SolidColor(0xAABBCC))
    }

    @Test
    func `incorrect format`() {
        let resolver = SolidColorResolver()
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
    }
}
