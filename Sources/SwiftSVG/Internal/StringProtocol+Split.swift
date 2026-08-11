//
//  Created by Kurlovich Vitali on 8/11/26.
//

import struct Foundation.CharacterSet

extension StringProtocol {
    func split(characters: CharacterSet, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> [SubSequence] {
        split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences) { char in
            let unicodeScalar = char.unicodeScalars.first!
            return characters.contains(unicodeScalar)
        }
    }

    func split(character: Character, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> [SubSequence] {
        split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences) { char in
            char == character
        }
    }
}
