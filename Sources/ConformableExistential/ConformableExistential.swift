@_exported public import struct SwiftExtras.AdHocCodingKey
// The above exported import [leaks](https://forums.swift.org/t/pitch-access-level-on-import-statements/66657/21)
// `SwiftExtras.Equatable+Extras` equality extensions which is generally considered unwanted
// and perhaps fixed in the future. Once the leak is plugged, we need to either reexport it
// or redeclare in this module.
import SwiftSyntaxExtras

// MARK: - Conforming Existential Wrapper Macros

/// Spawns `Equatable` property wrapper variants (regular, mutable, optional, sequence and their combinations)
/// over existentials of the annotated protocol.
/// - Requires: Annotated type must be a protocol that conforms to `Equatable`.
@attached(peer, names: prefixed(Equatable), prefixed(EquatableMutable), prefixed(EquatableOptional), prefixed(EquatableSequenceOf), prefixed(EquatableMutableOptional), prefixed(EquatableMutableSequenceOf), prefixed(EquatableOptionalSequenceOf), prefixed(EquatableMutableOptionalSequenceOf))
public macro EquatableExistential(
    accessModifier: TypeAccessModifier? = nil
) = #externalMacro(module: "ConformableExistentialMacros", type: "EquatableExistential")

/// Spawns `Hashable` property wrapper variants (regular, mutable, optional, sequence and their combinations)
/// over existentials of the annotated protocol.
/// - Requires: Annotated type must be a protocol that conforms to `Hashable`.
@attached(peer, names: prefixed(Hashable), prefixed(HashableMutable), prefixed(HashableOptional), prefixed(HashableSequenceOf), prefixed(HashableMutableOptional), prefixed(HashableMutableSequenceOf), prefixed(HashableOptionalSequenceOf), prefixed(HashableMutableOptionalSequenceOf))
public macro HashableExistential(
    accessModifier: TypeAccessModifier? = nil
) = #externalMacro(module: "ConformableExistentialMacros", type: "HashableExistential")

/// Spawns `Decodable` property wrapper variants (regular, mutable, optional, sequence and their combinations)
/// over existentials of the annotated protocol.
/// - Requires: Annotated type must be a protocol that conforms to `Decodable`.
@attached(peer, names: prefixed(Decodable), prefixed(DecodableMutable), prefixed(DecodableOptional), prefixed(DecodableRangeReplaceableCollectionOf), prefixed(DecodableMutableOptional), prefixed(DecodableMutableRangeReplaceableCollectionOf), prefixed(DecodableOptionalRangeReplaceableCollectionOf), prefixed(DecodableMutableOptionalRangeReplaceableCollectionOf))
public macro DecodableExistential(
    accessModifier: TypeAccessModifier? = nil
) = #externalMacro(module: "ConformableExistentialMacros", type: "DecodableExistential")

/// Spawns `Encodable` property wrapper variants (regular, mutable, optional, sequence and their combinations)
/// over existentials of the annotated protocol.
/// - Requires: Annotated type must be a protocol that conforms to `Encodable`.
@attached(peer, names: prefixed(Encodable), prefixed(EncodableMutable), prefixed(EncodableOptional), prefixed(EncodableSequenceOf), prefixed(EncodableMutableOptional), prefixed(EncodableMutableSequenceOf), prefixed(EncodableOptionalSequenceOf), prefixed(EncodableMutableOptionalSequenceOf))
public macro EncodableExistential(
    accessModifier: TypeAccessModifier? = nil
) = #externalMacro(module: "ConformableExistentialMacros", type: "EncodableExistential")

/// Spawns `Codable` property wrapper variants (regular, mutable, optional, sequence and their combinations)
/// over existentials of the annotated protocol.
/// - Requires: Annotated type must be a protocol that conforms to `Codable`.
@attached(peer, names: prefixed(Codable), prefixed(CodableMutable), prefixed(CodableOptional), prefixed(CodableRangeReplaceableCollectionOf), prefixed(CodableMutableOptional), prefixed(CodableMutableRangeReplaceableCollectionOf), prefixed(CodableOptionalRangeReplaceableCollectionOf), prefixed(CodableMutableOptionalRangeReplaceableCollectionOf))
public macro CodableExistential(
    accessModifier: TypeAccessModifier? = nil
) = #externalMacro(module: "ConformableExistentialMacros", type: "CodableExistential")

/// Spawns `Equatable, Decodable` property wrapper variants (regular, mutable, optional, sequence and their combinations)
/// over existentials of the annotated protocol.
/// - Requires: Annotated type must be a protocol that conforms to `Equatable, Decodable`.
@attached(peer, names: prefixed(EquatableDecodable), prefixed(EquatableDecodableMutable), prefixed(EquatableDecodableOptional), prefixed(EquatableDecodableRangeReplaceableCollectionOf), prefixed(EquatableDecodableMutableOptional), prefixed(EquatableDecodableMutableRangeReplaceableCollectionOf), prefixed(EquatableDecodableOptionalRangeReplaceableCollectionOf), prefixed(EquatableDecodableMutableOptionalRangeReplaceableCollectionOf))
public macro EquatableDecodableExistential(
    accessModifier: TypeAccessModifier? = nil
) = #externalMacro(module: "ConformableExistentialMacros", type: "EquatableDecodableExistential")

/// Spawns `Equatable, Encodable` property wrapper variants (regular, mutable, optional, sequence and their combinations)
/// over existentials of the annotated protocol.
/// - Requires: Annotated type must be a protocol that conforms to `Equatable, Encodable`.
@attached(peer, names: prefixed(EquatableEncodable), prefixed(EquatableEncodableMutable), prefixed(EquatableEncodableOptional), prefixed(EquatableEncodableSequenceOf), prefixed(EquatableEncodableMutableOptional), prefixed(EquatableEncodableMutableSequenceOf), prefixed(EquatableEncodableOptionalSequenceOf), prefixed(EquatableEncodableMutableOptionalSequenceOf))
public macro EquatableEncodableExistential(
    accessModifier: TypeAccessModifier? = nil
) = #externalMacro(module: "ConformableExistentialMacros", type: "EquatableEncodableExistential")

/// Spawns `Equatable, Codable` property wrapper variants (regular, mutable, optional, sequence and their combinations)
/// over existentials of the annotated protocol.
/// - Requires: Annotated type must be a protocol that conforms to `Equatable, Codable`.
@attached(peer, names: prefixed(EquatableCodable), prefixed(EquatableCodableMutable), prefixed(EquatableCodableOptional), prefixed(EquatableCodableRangeReplaceableCollectionOf), prefixed(EquatableCodableMutableOptional), prefixed(EquatableCodableMutableRangeReplaceableCollectionOf), prefixed(EquatableCodableOptionalRangeReplaceableCollectionOf), prefixed(EquatableCodableMutableOptionalRangeReplaceableCollectionOf))
public macro EquatableCodableExistential(
    accessModifier: TypeAccessModifier? = nil
) = #externalMacro(module: "ConformableExistentialMacros", type: "EquatableCodableExistential")

/// Spawns `Hashable, Decodable` property wrapper variants (regular, mutable, optional, sequence and their combinations)
/// over existentials of the annotated protocol.
/// - Requires: Annotated type must be a protocol that conforms to `Hashable, Decodable`.
@attached(peer, names: prefixed(HashableDecodable), prefixed(HashableDecodableMutable), prefixed(HashableDecodableOptional), prefixed(HashableDecodableRangeReplaceableCollectionOf), prefixed(HashableDecodableMutableOptional), prefixed(HashableDecodableMutableRangeReplaceableCollectionOf), prefixed(HashableDecodableOptionalRangeReplaceableCollectionOf), prefixed(HashableDecodableMutableOptionalRangeReplaceableCollectionOf))
public macro HashableDecodableExistential(
    accessModifier: TypeAccessModifier? = nil
) = #externalMacro(module: "ConformableExistentialMacros", type: "HashableDecodableExistential")

/// Spawns `Hashable, Encodable` property wrapper variants (regular, mutable, optional, sequence and their combinations)
/// over existentials of the annotated protocol.
/// - Requires: Annotated type must be a protocol that conforms to `Hashable, Encodable`.
@attached(peer, names: prefixed(HashableEncodable), prefixed(HashableEncodableMutable), prefixed(HashableEncodableOptional), prefixed(HashableEncodableSequenceOf), prefixed(HashableEncodableMutableOptional), prefixed(HashableEncodableMutableSequenceOf), prefixed(HashableEncodableOptionalSequenceOf), prefixed(HashableEncodableMutableOptionalSequenceOf))
public macro HashableEncodableExistential(
    accessModifier: TypeAccessModifier? = nil
) = #externalMacro(module: "ConformableExistentialMacros", type: "HashableEncodableExistential")

/// Spawns `Hashable, Codable` property wrapper variants (regular, mutable, optional, sequence and their combinations)
/// over existentials of the annotated protocol.
/// - Requires: Annotated type must be a protocol that conforms to `Hashable, Codable`.
@attached(peer, names: prefixed(HashableCodable), prefixed(HashableCodableMutable), prefixed(HashableCodableOptional), prefixed(HashableCodableRangeReplaceableCollectionOf), prefixed(HashableCodableMutableOptional), prefixed(HashableCodableMutableRangeReplaceableCollectionOf), prefixed(HashableCodableOptionalRangeReplaceableCollectionOf), prefixed(HashableCodableMutableOptionalRangeReplaceableCollectionOf))
public macro HashableCodableExistential(
    accessModifier: TypeAccessModifier? = nil
) = #externalMacro(module: "ConformableExistentialMacros", type: "HashableCodableExistential")

// MARK: - Coding

@attached(peer, names: suffixed(SimpleCoding))
public macro SimpleCodingProviding(
    accessModifier: TypeAccessModifier? = nil,
    expectedTypes: Any.Type...
) = #externalMacro(module: "ConformableExistentialMacros", type: "SimpleCoding")
