import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxExtras
import SwiftSyntaxMacros

public enum SimpleCoding: PeerMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {

        do {
            guard let protocolDeclSyntax = try? DeclSyntaxScanner(declSyntax: declaration), case .protocol = protocolDeclSyntax.type else {
                throw Diagnostic.invalidDeclarationType(declaration, expected: [ProtocolDeclSyntax.self]).error(at: node)
            }
            let protocolName = try protocolDeclSyntax.name
            let attributeSyntaxScanner = AttributeSyntaxScanner(node: node)
            let expectedArgumentsParameter = "expectedTypes"
            let expectedTypes = try attributeSyntaxScanner.memberAccessArguments(with: expectedArgumentsParameter) ?? { throw Diagnostic.invalidArgument(expectedArgumentsParameter).error(at: node) }()
            let expectedTypeNames = try expectedTypes.map {
                try $0.typeName ?? { throw Diagnostic.invalidArgument("Invalid member in '\(expectedArgumentsParameter)'.").error(at: node) }()
            }
            let accessModifier = try TypeAccessModifier(withLabel: "accessModifier", in: declaration, at: node)
            let accessModifierWithTrailingSpace = accessModifier.map { String(describing: $0) + " " } ?? ""
            let memberAccessModifierWithTrailingSpace = accessModifier.map { String(describing: $0.memberDerivate) + " " } ?? ""
            let typePairs = expectedTypeNames.map({ "\"\($0)\": \($0).self," }).joined(separator: "\n")
            let declSyntax = DeclSyntax(
            """
            \(raw: accessModifierWithTrailingSpace)struct \(raw: protocolName)SimpleCoding: CodingProvider {

                private enum Error: Swift.Error {
                    case unexpectedType(any \(raw: protocolName).Type)
                    case unexpectedTypeKey(String)
                }

                \(raw: memberAccessModifierWithTrailingSpace)static let shouldEncodeNil = false
                private static let typeCondingKey = AdHocCodingKey(stringValue: "__type")
                private static let expectedTypes: [String: any \(raw: protocolName).Type] = [
                    \(raw: typePairs)
                ]

                \(raw: memberAccessModifierWithTrailingSpace)static func encode(_ value: any \(raw: protocolName), to encoder: Encoder) throws {
                    var container = encoder.container(keyedBy: AdHocCodingKey.self)
                    guard let type = expectedTypes.first(where: { $1 == type(of: value) })?.key else {
                        throw Error.unexpectedType(type(of: value))
                    }
                    try container.encode(type, forKey: typeCondingKey)
                    try value.encode(to: encoder)
                }

                \(raw: memberAccessModifierWithTrailingSpace)static func decode(from decoder: Decoder) throws -> any \(raw: protocolName) {
                    let container = try decoder.container(keyedBy: AdHocCodingKey.self)
                    let typeName = try container.decode(String.self, forKey: typeCondingKey)
                    guard let type = expectedTypes[typeName] else {
                        throw Error.unexpectedTypeKey(typeName)
                    }
                    return try type.init(from: decoder) as any \(raw: protocolName)
                }
            }
            """
            )
            return [declSyntax]

        } catch {
            throw error.diagnosticError(at: node)
        }
    }
}
