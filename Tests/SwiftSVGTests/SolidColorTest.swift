//
//  Created by Kurlovich Vitali on 8/10/26.
//

import SwiftSVG
import Testing

struct SolidColorTest {
    @Test
    func hex() {
        #expect(
            SolidColor(0xFF0000) == SolidColor(red: UInt8(255), green: 0, blue: 0),
        )

        #expect(
            SolidColor(0x00FF00) == SolidColor(red: 0, green: UInt8(255), blue: 0),
        )

        #expect(
            SolidColor(0x0000FF) == SolidColor(red: 0, green: 0, blue: UInt8(255)),
        )
    }
}
