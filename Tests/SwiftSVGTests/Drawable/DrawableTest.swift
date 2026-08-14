//
//  Created by Kurlovich Vitali on 8/14/26.
//

import SwiftSVG
import Testing

struct DrawableTest {
    @Test func `is type of`() {
        let drawable = Drawable<Int>(String.self, style: .default)

        #expect(drawable.isTypeOf(String.self))
    }

    @Test func `subscript`() {
        var drawable = Drawable<Int>(type: "none", style: .default)

        drawable[String.self] = "Hello"

        drawable[Int.self] = 123

        #expect(drawable[String.self] == "Hello")
        #expect(drawable[Int.self] == 123)

        #expect(drawable[Float.self] == nil)
    }

    @Test func group() {
        let group = Drawable<String>.group(style: .default, childs: [])

        #expect(group.isGroup == true)
    }
}
