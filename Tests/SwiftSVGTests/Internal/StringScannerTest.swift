//
//  Created by Kurlovich Vitali on 8/6/26.
//

import Foundation
@testable import SwiftSVG
import Testing

struct StringScannerTest {
    @Test
    func `Empty string`() {
        var scaner = StringScanner("")

        #expect(scaner.isEnd == true)
        #expect(scaner.isFinish == true)
        #expect(scaner.nextChar() == nil)
    }

    @Test
    func `One symbol string`() {
        var scaner = StringScanner("A")

        #expect(scaner.isEnd == false)
        #expect(scaner.isFinish == false)
        #expect(scaner.nextChar() == "A")

        #expect(scaner.isEnd == true)
        #expect(scaner.isFinish == true)
        #expect(scaner.nextChar() == nil)
    }

    @Test
    func `Multiple symbol string`() {
        var scaner = StringScanner("ABCD")

        #expect(scaner.isEnd == false)
        #expect(scaner.isFinish == false)
        #expect(scaner.nextChar() == "A")

        #expect(scaner.isEnd == false)
        #expect(scaner.isFinish == false)
        #expect(scaner.nextChar() == "B")

        #expect(scaner.isEnd == false)
        #expect(scaner.isFinish == false)
        #expect(scaner.nextChar() == "C")

        #expect(scaner.isEnd == false)
        #expect(scaner.isFinish == false)
        #expect(scaner.nextChar() == "D")

        #expect(scaner.isEnd == true)
        #expect(scaner.isFinish == true)
        #expect(scaner.nextChar() == nil)
    }

    @Test
    func `Skip in empty string`() {
        var scaner = StringScanner("")

        #expect(scaner.skip(in: CharacterSet.decimalDigits) == "")

        #expect(scaner.isEnd == true)
        #expect(scaner.isFinish == true)
        #expect(scaner.nextChar() == nil)
    }

    @Test
    func skip() {
        var scaner = StringScanner("1")

        #expect(scaner.skip(in: CharacterSet.decimalDigits) == "1")

        #expect(scaner.isEnd == true)
        #expect(scaner.isFinish == true)
        #expect(scaner.nextChar() == nil)

        scaner = StringScanner("12")
        #expect(scaner.skip(in: CharacterSet.decimalDigits) == "12")

        #expect(scaner.isEnd == true)
        #expect(scaner.isFinish == true)
        #expect(scaner.nextChar() == nil)

        scaner = StringScanner("12A")
        #expect(scaner.skip(in: CharacterSet.decimalDigits) == "12")

        #expect(scaner.isEnd == false)
        #expect(scaner.isFinish == false)
        #expect(scaner.nextChar() == "A")

        #expect(scaner.isEnd == true)
        #expect(scaner.isFinish == true)
        #expect(scaner.nextChar() == nil)

        scaner = StringScanner("A12")
        #expect(scaner.skip(in: CharacterSet.decimalDigits) == "")

        #expect(scaner.isEnd == false)
        #expect(scaner.isFinish == false)
        #expect(scaner.nextChar() == "A")

        #expect(scaner.skip(in: CharacterSet.decimalDigits) == "12")

        #expect(scaner.isEnd == true)
        #expect(scaner.isFinish == true)
        #expect(scaner.nextChar() == nil)

        scaner = StringScanner("A12B")
        #expect(scaner.skip(in: CharacterSet.decimalDigits) == "")

        #expect(scaner.isEnd == false)
        #expect(scaner.isFinish == false)
        #expect(scaner.nextChar() == "A")

        #expect(scaner.skip(in: CharacterSet.decimalDigits) == "12")

        #expect(scaner.isEnd == false)
        #expect(scaner.isFinish == false)
        #expect(scaner.nextChar() == "B")

        #expect(scaner.isEnd == true)
        #expect(scaner.isFinish == true)
        #expect(scaner.nextChar() == nil)
    }

    @Test
    func `SkipTo in empty string`() {
        var scaner = StringScanner("")

        #expect(scaner.skip(to: CharacterSet.decimalDigits) == "")

        #expect(scaner.isEnd == true)
        #expect(scaner.isFinish == true)
        #expect(scaner.nextChar() == nil)
    }

    @Test
    func `SkipTo in string`() {
        var scaner = StringScanner("1")

        #expect(scaner.skip(to: CharacterSet.decimalDigits) == "")

        #expect(scaner.isEnd == false)
        #expect(scaner.isFinish == false)
        #expect(scaner.nextChar() == "1")

        scaner = StringScanner("A1")

        #expect(scaner.skip(to: CharacterSet.decimalDigits) == "A")

        #expect(scaner.isEnd == false)
        #expect(scaner.isFinish == false)
        #expect(scaner.nextChar() == "1")

        scaner = StringScanner("A123BB2")

        #expect(scaner.skip(to: CharacterSet.decimalDigits) == "A")

        #expect(scaner.isEnd == false)
        #expect(scaner.isFinish == false)
        #expect(scaner.skip(to: CharacterSet.decimalDigits) == "")
    }
}
