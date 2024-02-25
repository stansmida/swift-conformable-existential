/// A type that can be converted to and from an associated value where the value
/// is meant to be a protocol metatype.
///
/// A `ProtocolMetatypeRepresentable` type is designed to encode and decode a metatype
/// representation of any type that conforms to the associated protocol.
///
/// A `ProtocolMetatypeRepresentable` type conforms to `MetaCoding` and is meant to
/// be used as `TypeCoding` in codable wrappers synthesized from macros in this package.
///
/// See more in <doc:Essentials#Coding>.
public protocol ProtocolMetatypeRepresentable: Codable, MetaCoding where ProtocolMetatype == Meta {

    /// In order to work with `TypeCoding` generic parameter, it must be expressed as
    /// a protocol metatype, for instance `any Drinkable.Type`.
    associatedtype ProtocolMetatype

    associatedtype CodingKey: Swift.CodingKey

    init?(_ type: ProtocolMetatype)

    static var codingKey: CodingKey { get }

    var type: ProtocolMetatype { get }
}

public extension ProtocolMetatypeRepresentable {

    /// ``MetaDecoding`` default implementation.
    static func decode(from decoder: Decoder) throws -> ProtocolMetatype {
        let container = try decoder.container(keyedBy: CodingKey.self)
        let typeRepresentation = try container.decode(Self.self, forKey: Self.codingKey)
        return typeRepresentation.type
    }

    /// ``MetaEncoding`` default implementation.
    static func encode(_ meta: ProtocolMetatype, to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKey.self)
        guard let typeRepresentation = Self(meta) else {
            throw EncodingError.invalidValue(
                meta,
                EncodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Cannot initialize \(Self.self) from invalid \(ProtocolMetatype.self) value \(meta)."
                )
            )
        }
        try container.encode(typeRepresentation, forKey: Self.codingKey)
    }
}
