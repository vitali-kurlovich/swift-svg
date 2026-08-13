//
//  Created by Kurlovich Vitali on 8/6/26.
//

import struct Foundation.CharacterSet

struct CommandIterator<S: StringProtocol>: IteratorProtocol {
    var scanner: StringScanner<S>

    init(_ string: S) {
        scanner = StringScanner(string)
    }

    mutating func next() -> PathElement? {
        _ = scanner.skip(in: .whitespacesNewlinesAndCommma)

        guard let char = scanner.nextChar() else {
            return nil
        }

        guard let command = Command(rawValue: char) else {
            return nil
        }

        return PathElement(
            command: command,
            arguments: argsuments(for: command),
        )
    }

    mutating func argsuments(for command: Command) -> [S.SubSequence] {
        if command == .z || command == .Z {
            return []
        }

        var argsuments: [S.SubSequence] = []

        let count = command.argsCount
        argsuments.reserveCapacity(count)

        while true {
            _ = scanner.skip(in: .whitespacesNewlinesAndCommma)

            let string = scanner.skip(in: .decimalDigitsAndFractionSeparator)

            if string.isEmpty {
                break
            }

            argsuments.append(string)
        }

        return argsuments
    }
}

extension CommandIterator {
    struct PathElement: Equatable {
        let command: Command
        let arguments: [S.SubSequence]

        func makeIterator() -> CommandArgumentsIterator {
            CommandArgumentsIterator(iterator: arguments.makeIterator())
        }
    }

    struct CommandArgumentsIterator: IteratorProtocol {
        typealias Element = [S.SubSequence].Element

        var iterator: [S.SubSequence].Iterator

        mutating func next() -> Element? {
            iterator.next()
        }

        mutating func nextDouble() -> Double? {
            guard let string = iterator.next() else {
                return nil
            }

            return Double(string)
        }

        mutating func nextInt() -> Int? {
            guard let string = iterator.next() else {
                return nil
            }

            return Int(string)
        }
    }
}

extension CommandIterator {
    enum Command: Character {
        case M = "M"
        case m = "m"

        case L = "L"
        case l = "l"

        case H = "H"
        case h = "h"

        case v = "v"
        case V = "V"

        case C = "C"
        case c = "c"

        case S = "S"
        case s = "s"

        case Q = "Q"
        case q = "q"

        case T = "T"
        case t = "t"

        case A = "A"
        case a = "a"

        case Z = "Z"
        case z = "z"

        var argsCount: Int {
            switch self {
            case .Z, .z:
                0
            case .H, .h, .V, .v:
                1
            case .M, .m, .L, .l, .T, .t:
                2
            case .S, .s, .Q, .q:
                4
            case .C, .c:
                6
            case .A, .a:
                7
            }
        }
    }
}
