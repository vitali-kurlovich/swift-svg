//
//  Created by Kurlovich Vitali on 8/6/26.
//

import struct Foundation.CharacterSet

struct StringScanner<S: StringProtocol> {
    let string: S

    var startIndex: S.Index
    var isFinish: Bool

    init(
        _ string: S,
    ) {
        self.string = string
        startIndex = string.startIndex
        isFinish = string.isEmpty
    }
}

extension StringScanner {
    var isEnd: Bool {
        startIndex == endIndex
    }

    var endIndex: S.Index {
        string.endIndex
    }

    private var currentChar: Character {
        string[startIndex]
    }
}

extension StringScanner {
    mutating func skip(in set: CharacterSet) -> S.SubSequence {
        let begin = startIndex

        while true {
            if isFinish {
                break
            }

            let unicodeScalar = currentChar.unicodeScalars.first!

            if set.contains(unicodeScalar) {
                if isEnd == false {
                    startIndex = string.index(after: startIndex)
                }

                isFinish = isEnd

            } else {
                break
            }
        }

        return string[begin ..< startIndex]
    }

    mutating func nextChar() -> Character? {
        if isFinish {
            return nil
        }

        defer {
            if isEnd == false {
                startIndex = string.index(after: startIndex)
            }

            isFinish = isEnd
        }

        return currentChar
    }
}
