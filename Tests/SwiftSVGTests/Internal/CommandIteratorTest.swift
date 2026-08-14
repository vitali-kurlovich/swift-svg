//
//  Created by Kurlovich Vitali on 8/5/26.
//

@testable import SwiftSVG
import Testing

struct CommandsSequence<S: StringProtocol>: Sequence {
    let string: S

    func makeIterator() -> CommandIterator<S> {
        CommandIterator(string)
    }
}

typealias PathElement = CommandIterator<String>.PathElement

struct CommandIteratorTest {
    @Test
    func `M tag`() {
        #expect(
            Array(CommandsSequence(string: "M78,98")) == [
                PathElement(command: .M, arguments: ["78", "98"]),
            ],
        )

        #expect(
            Array(CommandsSequence(string: "  M78,98")) == [
                PathElement(command: .M, arguments: ["78", "98"]),
            ],
        )

        #expect(
            Array(CommandsSequence(string: "  M78,   98   ")) == [
                PathElement(command: .M, arguments: ["78", "98"]),
            ],
        )

        #expect(
            Array(CommandsSequence(string: """
             M78,   98  
            """)) == [
                PathElement(command: .M, arguments: ["78", "98"]),
            ],
        )

        #expect(
            Array(CommandsSequence(string: "  M78,   98   z  ")) == [
                PathElement(command: .M, arguments: ["78", "98"]),
                PathElement(command: .z, arguments: []),
            ],
        )
    }
}
