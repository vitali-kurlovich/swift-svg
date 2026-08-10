//
//  Created by Kurlovich Vitali on 8/8/26.
//

import Foundation
@testable import SwiftSVG
import Testing

struct SplitIteratorTest {
    @Test
    func `empty String`() {
        var iterator = SplitIterator(string: "", separator: ":")
        #expect(iterator.next() == nil)

        iterator = SplitIterator(string: "Aa:Bb", separator: ":")
        #expect(iterator.next() == "Aa")
        #expect(iterator.next() == "Bb")
        #expect(iterator.next() == nil)
    }
}
