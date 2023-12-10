/// A private marker protocol that specifies macro expansion types for `KeyedDecodingContainer`
/// to handle decoding optional values that may be nil.
/// - Important: This type is part of the internal implementation of `ConformableExistential` package.
/// It is public due to technical requirements but is not intended for direct use by client code.
public protocol _OptionalExistentialDecodingSupport {
    associatedtype T
    init(wrappedValue: T?)
}

/// A private marker protocol that specifies macro expansion types for `KeyedEncodingContainer`
/// to handle encoding nil values.
/// - Important: This type is part of the internal implementation of `ConformableExistential` package.
/// It is public due to technical requirements but is not intended for direct use by client code.
public protocol _OptionalExistentialEncodingSupport {
    associatedtype Coding: EncodingProvider
    associatedtype T
    var wrappedValue: T? { get }
}

public extension KeyedDecodingContainer {

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: _OptionalExistentialDecodingSupport, T: Decodable {
        try decodeIfPresent(type, forKey: key) ?? T(wrappedValue: nil)
    }
}

public extension KeyedEncodingContainer {

    mutating func encode<T>(_ value: T, forKey key: Key) throws where T: _OptionalExistentialEncodingSupport, T: Encodable {
        if value.wrappedValue == nil {
            if T.Coding.shouldEncodeNil {
                try encodeNil(forKey: key)
            } else {
                return
            }
        } else {
            // Always encodes, just avoids infinite resursion.
            try encodeIfPresent(value, forKey: key)
        }
    }
}
