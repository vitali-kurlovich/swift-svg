//
//  Created by Kurlovich Vitali on 8/1/26.
//

import Foundation
import OSLog

public struct SVGParser {
    public init() {}
}

public extension SVGParser {
    func parse(data: Data) -> SvgDocument? {
        let parser = XMLParser(data: data)

        let logger = Logger(subsystem: "SVGParser", category: "xml")

        let parserDelegate = SVGParserDelegate(logger: logger)

        parser.delegate = parserDelegate

        parser.parse()

        guard let root = parserDelegate.root else {
            return nil
        }

        return SvgDocument(svg: root)
    }
}

final class SVGParserDelegate: NSObject, XMLParserDelegate {
    var root: SvgTag?
    private var stack: [any SVGMutableElement] = []

    let logger: Logger?

    init(logger: Logger? = nil) {
        self.logger = logger
    }

    func parserDidStartDocument(_: XMLParser) {
        logger?.debug(#function)
        stack.removeAll(keepingCapacity: true)
        root = nil
    }

    func parserDidEndDocument(_: XMLParser) {
        logger?.debug(#function)
        assert(stack.isEmpty)
    }

    /**
     func parser(_: XMLParser, foundNotationDeclarationWithName name: String, publicID: String?, systemID: String?) {
         logger?.debug("\(#function) name:\(name), publicID: \(publicID ?? "nil"), systemID: \(systemID ?? "nil")")
     }
     */
    func parser(_: XMLParser, foundUnparsedEntityDeclarationWithName name: String, publicID: String?, systemID: String?, notationName: String?) {
        logger?.debug("\(#function) name:\(name), publicID: \(publicID ?? "nil"), systemID: \(systemID ?? "nil"), notationName: \(notationName ?? "nil")")
    }

    func parser(_: XMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?) {
        logger?.debug("\(#function) attributeName:\(attributeName), elementName: \(elementName), type: \(type ?? "nil"), defaultValue: \(defaultValue ?? "nil")")
    }

    func parser(_: XMLParser, foundElementDeclarationWithName elementName: String, model: String) {
        logger?.debug("\(#function) elementName:\(elementName), model: \(model)")
    }

    func parser(_: XMLParser, foundInternalEntityDeclarationWithName name: String, value: String?) {
        logger?.debug("\(#function) name:\(name), value: \(value ?? "nil")")
    }

    func parser(_: XMLParser, foundExternalEntityDeclarationWithName name: String, publicID: String?, systemID: String?) {
        logger?.debug("\(#function) name:\(name), publicID: \(publicID ?? "nil"), systemID: \(systemID ?? "nil")")
    }

    func parser(_: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        logger?.debug("\(#function) didStartElement:\(elementName), namespaceURI: \(namespaceURI ?? "nil"), qualifiedName: \(qName ?? "nil"), attributes: \(attributeDict)")

        switch elementName {
        case SvgTag.name:
            stack.append(SvgTag(attributes: attributeDict))

        case GTag.name:
            stack.append(GTag(attributes: attributeDict))

        case PathTag.name:
            stack.append(PathTag(attributes: attributeDict))

        case CircleTag.name:
            stack.append(CircleTag(attributes: attributeDict))

        case EllipseTag.name:
            stack.append(EllipseTag(attributes: attributeDict))

        case DefsTag.name:
            stack.append(DefsTag(attributes: attributeDict))

        case UseTag.name:
            stack.append(UseTag(attributes: attributeDict))

        default:
            break
        }
    }

    func parser(_: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        logger?.debug("\(#function) didEndElement:\(elementName), namespaceURI: \(namespaceURI ?? "nil"), qualifiedName: \(qName ?? "nil")")

        switch elementName {
        case SvgTag.name:
            guard let root = stack.popLast() as? SvgTag else {
                assertionFailure()
                return
            }

            self.root = root

        case GTag.name:
            append(tag: GTag.self)

        case PathTag.name:
            append(tag: PathTag.self)

        case CircleTag.name:
            append(tag: CircleTag.self)

        case EllipseTag.name:
            append(tag: EllipseTag.self)

        case DefsTag.name:
            append(tag: DefsTag.self)

        case UseTag.name:
            append(tag: UseTag.self)

        default:
            break
        }
    }

    private func append<T: SVGElement>(tag _: T.Type) {
        guard let tag = stack.popLast() as? T else {
            assertionFailure()
            return
        }

        guard var parent = stack.popLast() else {
            assertionFailure()
            return
        }
        parent.childs.append(tag)

        stack.append(parent)
    }

    /*
     func parser(_: XMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String) {
         logger?.debug("\(#function) didStartMappingPrefix:\(prefix), toURI: \(namespaceURI)")
     }

     func parser(_: XMLParser, didEndMappingPrefix prefix: String) {
         logger?.debug("\(#function) didEndMappingPrefix:\(prefix)")
     }

     func parser(_: XMLParser, foundCharacters string: String) {
         logger?.debug("\(#function) foundCharacters:\(string)")
     }

     func parser(_: XMLParser, foundIgnorableWhitespace whitespaceString: String) {
         logger?.debug("\(#function) whitespaceString:\(whitespaceString)")
     }

     func parser(_: XMLParser, foundProcessingInstructionWithTarget target: String, data: String?) {
         logger?.debug("\(#function) foundProcessingInstructionWithTarget:\(target), data:\(data ?? "nil")")
     }

     func parser(_: XMLParser, foundComment comment: String) {
         logger?.debug("\(#function) foundComment:\(comment)")
     }

     func parser(_: XMLParser, foundCDATA CDATABlock: Data) {
         logger?.debug("\(#function) foundCDATA:\(self.format(data: CDATABlock))")
     }

     func parser(_: XMLParser, parseErrorOccurred parseError: any Error) {
         logger?.debug(
             "\(#function) parseErrorOccurred:\(parseError.localizedDescription)",
         )
     }

     func parser(_: XMLParser, validationErrorOccurred validationError: any Error) {
         logger?.debug(
             "\(#function) validationErrorOccurred:\(validationError.localizedDescription)",
         )
     }
     */
}
