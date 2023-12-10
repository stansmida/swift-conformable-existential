import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(SwiftConformableExistentialMacros)
import SwiftConformableExistentialMacros
#endif

final class SimpleCodingTests: XCTestCase {

    func testSimpleCoding() throws {
        #if canImport(SwiftConformableExistentialMacros)
        assertMacroExpansion(
            """
            @SimpleCodingProviding(accessModifier: .public, expectedTypes: Cat.self, Cow.self)
            public protocol Animal {}
            """,
            expandedSource: """
            public protocol Animal {}

            public struct AnimalSimpleCoding: CodingProvider {

                private enum Error: Swift.Error {
                    case unexpectedType(any Animal.Type)
                    case unexpectedTypeKey(String)
                }

                public static let shouldEncodeNil = false
                private static let typeCondingKey = AdHocCodingKey(stringValue: "__type")
                private static let expectedTypes: [String: any Animal.Type] = [
                    "Cat": Cat.self,
                    "Cow": Cow.self,
                ]

                public static func encode(_ value: any Animal, to encoder: Encoder) throws {
                    var container = encoder.container(keyedBy: AdHocCodingKey.self)
                    guard let type = expectedTypes.first(where: {
                            $1 == type(of: value)
                        })?.key else {
                        throw Error.unexpectedType(type(of: value))
                    }
                    try container.encode(type, forKey: typeCondingKey)
                    try value.encode(to: encoder)
                }

                public static func decode(from decoder: Decoder) throws -> any Animal {
                    let container = try decoder.container(keyedBy: AdHocCodingKey.self)
                    let typeName = try container.decode(String.self, forKey: typeCondingKey)
                    guard let type = expectedTypes[typeName] else {
                        throw Error.unexpectedTypeKey(typeName)
                    }
                    return try type.init(from: decoder) as any Animal
                }
            }
            """,
            macros: ["SimpleCodingProviding": SimpleCoding.self]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
