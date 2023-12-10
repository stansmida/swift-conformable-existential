import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxExtras
import SwiftSyntaxMacros

public enum EquatableExistential: PeerMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        try Configuration.allVariants
            .map { try ExpansionBuilder(configuration: .init(for: declaration, at: node, conformance: .init(equality: .equatable, codability: nil), variant: $0)).build() }
            .flatMap { $0 }
    }
}

public enum HashableExistential: PeerMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        try Configuration.allVariants
            .map { try ExpansionBuilder(configuration: .init(for: declaration, at: node, conformance: .init(equality: .hashable, codability: nil), variant: $0)).build() }
            .flatMap { $0 }
    }
}

public enum DecodableExistential: PeerMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        try Configuration.allVariants
            .map { try ExpansionBuilder(configuration: .init(for: declaration, at: node, conformance: .init(equality: nil, codability: .decodable), variant: $0)).build() }
            .flatMap { $0 }
    }
}

public enum EncodableExistential: PeerMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        try Configuration.allVariants
            .map { try ExpansionBuilder(configuration: .init(for: declaration, at: node, conformance: .init(equality: nil, codability: .encodable), variant: $0)).build() }
            .flatMap { $0 }
    }
}

public enum CodableExistential: PeerMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        try Configuration.allVariants
            .map { try ExpansionBuilder(configuration: .init(for: declaration, at: node, conformance: .init(equality: nil, codability: .codable), variant: $0)).build() }
            .flatMap { $0 }
    }
}

public enum EquatableDecodableExistential: PeerMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        try Configuration.allVariants
            .map { try ExpansionBuilder(configuration: .init(for: declaration, at: node, conformance: .init(equality: .equatable, codability: .decodable), variant: $0)).build() }
            .flatMap { $0 }
    }
}

public enum EquatableEncodableExistential: PeerMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        try Configuration.allVariants
            .map { try ExpansionBuilder(configuration: .init(for: declaration, at: node, conformance: .init(equality: .equatable, codability: .encodable), variant: $0)).build() }
            .flatMap { $0 }
    }
}

public enum EquatableCodableExistential: PeerMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        try Configuration.allVariants
            .map { try ExpansionBuilder(configuration: .init(for: declaration, at: node, conformance: .init(equality: .equatable, codability: .codable), variant: $0)).build() }
            .flatMap { $0 }
    }
}

public enum HashableDecodableExistential: PeerMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        try Configuration.allVariants
            .map { try ExpansionBuilder(configuration: .init(for: declaration, at: node, conformance: .init(equality: .hashable, codability: .decodable), variant: $0)).build() }
            .flatMap { $0 }
    }
}

public enum HashableEncodableExistential: PeerMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        try Configuration.allVariants
            .map { try ExpansionBuilder(configuration: .init(for: declaration, at: node, conformance: .init(equality: .hashable, codability: .encodable), variant: $0)).build() }
            .flatMap { $0 }
    }
}

public enum HashableCodableExistential: PeerMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        try Configuration.allVariants
            .map { try ExpansionBuilder(configuration: .init(for: declaration, at: node, conformance: .init(equality: .hashable, codability: .codable), variant: $0)).build() }
            .flatMap { $0 }
    }
}

// MARK: - Builder

fileprivate struct Configuration {

    struct Conformance: Hashable {
        
        enum Codability: String { case decodable = "Decodable", encodable = "Encodable", codable = "Codable" }
        enum Equality: String { case equatable = "Equatable", hashable = "Hashable" }

        let equality: Equality?
        let codability: Codability?
    }

    enum Variant {
        case mutable, optional, sequence
    }

    static let allVariants: [Set<Variant>] = [
        [],
        [.mutable],
        [.optional],
        [.sequence],
        [.mutable, .optional],
        [.mutable, .sequence],
        [.optional, .sequence],
        [.mutable, .optional, .sequence]
    ]

    init(
        for declaration: some DeclSyntaxProtocol,
        at node: AttributeSyntax,
        conformance: Conformance,
        variant: Set<Configuration.Variant>
    ) throws {
        do {
            let protocolDeclSyntax = try DeclSyntaxScanner(declSyntax: declaration)
            guard case .protocol = protocolDeclSyntax.type else {
                throw Diagnostic.invalidDeclarationType(declaration, expected: [ProtocolDeclSyntax.self]).error(at: node)
            }
            self.node = node
            self.accessModifier = try TypeAccessModifier(withLabel: "accessModifier", in: declaration, at: node)
            self.protocolName = try protocolDeclSyntax.name
            self.conformance = conformance
            self.variant = variant
        } catch {
            throw error.diagnosticError(at: node)
        }
    }

    let node: AttributeSyntax
    let accessModifier: TypeAccessModifier?
    let protocolName: String
    let conformance: Conformance
    let variant: Set<Variant>
}

private struct ExpansionBuilder {

    let configuration: Configuration

    func build() throws -> [DeclSyntax] {
        do {
            return [DeclSyntax(try typeDecl)]
        } catch {
            throw error.diagnosticError(at: configuration.node)
        }
    }

    // MARK: Components

    private var typeDecl: StructDeclSyntax {
        get throws {
            try StructDeclSyntax(typeHeader) {
                members
            }
            .with(\.leadingTrivia, .docLineComment(docLineComment))
        }
    }

    private var typeHeader: SyntaxNodeString {
        """
        @propertyWrapper
        \(raw: accessModifierWithTrailingSpace)\
        struct \(raw: typeName)\
        \(raw: genericParameterClause)\
        \(raw: inheritanceClause)\
        \(raw: genericWhereClause)
        """
    }

    private var accessModifierWithTrailingSpace: String {
        configuration.accessModifier.map { String(describing: $0) + " " } ?? ""
    }

    private var typeName: String {
        var variantComponent = ""
        if configuration.variant.contains(.mutable) {
            variantComponent += "Mutable"
        }
        if configuration.variant.contains(.optional) {
            variantComponent += "Optional"
        }
        if configuration.variant.contains(.sequence) {
            variantComponent += "\(sequenceType)Of"
        }
        let typeName = conformanceComponent + variantComponent + configuration.protocolName
        return typeName
    }

    private var sequenceType: String {
        if let codability = configuration.conformance.codability {
            codability == .encodable ? "Sequence" : "RangeReplaceableCollection"
        } else {
            "Sequence"
        }
    }

    private var conformanceComponent: String {
        var result = ""
        if let equality = configuration.conformance.equality {
            result += equality.rawValue
        }
        if let codability = configuration.conformance.codability {
            result += codability.rawValue
        }
        return result
    }

    private var genericParameterClause: String {
        var parameters = [String]()
        // Order matters.
        if configuration.variant.contains(.sequence) {
            parameters.append(sequenceGenericParameter)
        }
        if configuration.conformance.codability != nil {
            parameters.append(codingProviderGenericParameter)
        }
        if parameters.isEmpty {
            return ""
        } else {
            return "<\(parameters.joined(separator: ", "))>"
        }
    }

    private let sequenceGenericParameter = "T"

    private let codingProviderGenericParameter = "Coding"

    private var inheritanceClause: String {
        var conformances = [String]()
        if let equality = configuration.conformance.equality {
            if configuration.variant.contains(.sequence) {
                conformances.append("_ConformableExistentialEquatableSequenceSupport")
            } else {
                conformances.append("_ConformableExistentialEquatableSupport")
            }
            if equality == .hashable {
                conformances.append(Configuration.Conformance.Equality.hashable.rawValue)
            }
        }
        if let codability = configuration.conformance.codability {
            conformances.append(codability.rawValue)
            if configuration.variant.contains(.optional) {
                if codability == .decodable || codability == .codable {
                    conformances.append("_OptionalExistentialDecodingSupport")
                }
                if codability == .encodable || codability == .codable {
                    conformances.append("_OptionalExistentialEncodingSupport")
                }
            }
        }
        if conformances.isEmpty {
            return ""
        } else {
            return ": " + conformances.joined(separator: ", ")
        }
    }

    private var genericWhereClause: String {
        var constraints = [String]()
        if configuration.variant.contains(.sequence) {
            constraints.append("\(sequenceGenericParameter): \(sequenceType)<any \(configuration.protocolName)>")
        }
        if let codability = configuration.conformance.codability {
            let coding = switch codability {
            case .decodable: "Decoding"
            case .encodable: "Encoding"
            case .codable: "Coding"
            }
            constraints.append("\(codingProviderGenericParameter): \(coding)Provider<any \(configuration.protocolName)>")
        }
        if constraints.isEmpty {
            return ""
        } else {
            return " where \(constraints.joined(separator: ", "))"
        }
    }

    @MemberBlockItemListBuilder
    private var members: MemberBlockItemListBuilder.FinalResult {
        """
        \(raw: memberAccessModifierWithTrailingSpace)init(wrappedValue: \(raw: wrappedType)) {
            self.wrappedValue = wrappedValue
        }
        """
        "\(raw: memberAccessModifierWithTrailingSpace)\(raw: bindingSpecifier) wrappedValue: \(raw: wrappedType)"
        "\(raw: memberAccessModifierWithTrailingSpace)var projectedValue: Self { self }"
        if let equality = configuration.conformance.equality {
            if configuration.variant.contains(.sequence) {
                "\(raw: memberAccessModifierWithTrailingSpace)var _sequenceOfEquatables: \(raw: sequenceGenericParameter)? { wrappedValue }"
            } else {
                "\(raw: memberAccessModifierWithTrailingSpace)var _equatable: (any Equatable)? { wrappedValue }"
            }
            if equality == .hashable {
                """
                \(raw: memberAccessModifierWithTrailingSpace)func hash(into hasher: inout Hasher) {
                    \(hashIntoHasherBody)
                }
                """
            }
        }
        if let codability = configuration.conformance.codability {
            if codability == .decodable || codability == .codable {
                """
                \(raw: memberAccessModifierWithTrailingSpace)init(from decoder: Decoder) throws {
                    \(initFromDecoderBody)
                }
                """
            }
            if codability == .encodable || codability == .codable {
                """
                \(raw: memberAccessModifierWithTrailingSpace)func encode(to encoder: Encoder) throws {
                    \(encodeToEncoderBody)
                }
                """
            }
        }
    }

    private var memberAccessModifierWithTrailingSpace: String {
        configuration.accessModifier.map { String(describing: $0.memberDerivate) + " " } ?? ""
    }

    private var wrappedType: String {
        if configuration.variant.isSuperset(of: [.optional, .sequence]) {
            "\(sequenceGenericParameter)?"
        } else if configuration.variant.isSuperset(of: [.optional]) {
            "(any \(configuration.protocolName))?"
        } else if configuration.variant.isSuperset(of: [.sequence]) {
            "\(sequenceGenericParameter)"
        } else {
            "any \(configuration.protocolName)"
        }
    }

    private var bindingSpecifier: String {
        configuration.variant.contains(.mutable) ? "var" : "let"
    }

    @CodeBlockItemListBuilder
    private var hashIntoHasherBody: CodeBlockItemListBuilder.FinalResult {
        switch (configuration.variant.contains(.optional), configuration.variant.contains(.sequence)) {
            case (false, false):
                """
                hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                hasher.combine(wrappedValue)
                """
            case (false, true):
                """
                hasher.combine(ObjectIdentifier(\(raw: sequenceGenericParameter).self))
                for element in wrappedValue {
                    hasher.combine(ObjectIdentifier(type(of: element)))
                    hasher.combine(element)
                }
                """
            case (true, false):
                """
                if let wrappedValue {
                    hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                    hasher.combine(wrappedValue)
                } else {
                    hasher.combine(ObjectIdentifier(Optional<any \(raw: configuration.protocolName)>.self))
                }
                """
            case (true, true):
                """
                if let wrappedValue {
                    hasher.combine(ObjectIdentifier(\(raw: sequenceGenericParameter).self))
                    for element in wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: element)))
                        hasher.combine(element)
                    }
                } else {
                    hasher.combine(ObjectIdentifier(Optional<\(raw: sequenceGenericParameter)>.self))
                }
                """
        }
    }

    @CodeBlockItemListBuilder
    private var initFromDecoderBody: CodeBlockItemListBuilder.FinalResult {
        let nonNilDecoding = if configuration.variant.contains(.sequence) {
            """
            var container = try decoder.unkeyedContainer()
            var array = Array<any \(configuration.protocolName)>()
            if let count = container.count {
                array.reserveCapacity(count)
            }
            while !container.isAtEnd {
                let element = try container.decode(\(conformanceComponent)\(configuration.protocolName)<\(codingProviderGenericParameter)>.self).wrappedValue
                array.append(element)
            }
            wrappedValue = \(sequenceGenericParameter)(array)
            """
        } else {
            "wrappedValue = try \(codingProviderGenericParameter).decode(from: decoder)"
        }
        if configuration.variant.contains(.optional) {
            // Handles decoding an uncontained wrapper from "null" data.
            // Contained nulls are handled via `KeyedDecodingContainer` extension
            // that takes `_OptionalExistentialDecodingSupport` and decodes
            // conditionally (`decodeIfPresent`).
            """
            if (try? decoder.singleValueContainer().decodeNil()) == true {
                wrappedValue = nil
            } else {
                \(raw: nonNilDecoding)
            }
            """
        } else {
            "\(raw: nonNilDecoding)"
        }
    }

    @CodeBlockItemListBuilder
    private var encodeToEncoderBody: CodeBlockItemListBuilder.FinalResult {
        switch (configuration.variant.contains(.optional), configuration.variant.contains(.sequence)) {
            case (false, false):
                """
                try \(raw: codingProviderGenericParameter).encode(wrappedValue, to: encoder)
                """
            case (false, true):
                """
                var container = encoder.unkeyedContainer()
                try container.encode(contentsOf: wrappedValue.lazy.map { \(raw: conformanceComponent)\(raw: configuration.protocolName)<\(raw: codingProviderGenericParameter)>(wrappedValue: $0) })
                """
            case (true, false):
                """
                if let wrappedValue {
                    try \(raw: codingProviderGenericParameter).encode(wrappedValue, to: encoder)
                } else {
                    var container = encoder.singleValueContainer()
                    try container.encodeNil()
                }
                """
            case (true, true):
                """
                if let wrappedValue {
                    var container = encoder.unkeyedContainer()
                    try container.encode(contentsOf: wrappedValue.lazy.map { \(raw: conformanceComponent)\(raw: configuration.protocolName)<\(raw: codingProviderGenericParameter)>(wrappedValue: $0) })
                } else {
                    var container = encoder.singleValueContainer()
                    try container.encodeNil()
                }
                """
        }
    }

    private var docLineComment: String {
        if configuration.conformance.equality != nil, configuration.variant.contains(.sequence) {
            """
            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            """ + "\n"
        } else {
            ""
        }
    }
}
