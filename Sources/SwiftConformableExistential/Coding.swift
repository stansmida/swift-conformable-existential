/// A type that provides encoding of `EncodingSubject`.
public protocol EncodingProvider<EncodingSubject> {

    associatedtype EncodingSubject
    
    /// Whether should use ``encodeNil(forKey:)`` or not when encoding `nil` values.
    static var shouldEncodeNil: Bool { get }
    
    static func encode(_ type: EncodingSubject, to encoder: Encoder) throws
}

/// A type that provides decoding of `DecodingSubject`.
public protocol DecodingProvider<DecodingSubject> {
    
    associatedtype DecodingSubject

    static func decode(from decoder: Decoder) throws -> DecodingSubject
}

/// DecodingProvider & EncodingProvider with primary associated type.
public protocol CodingProvider<Subject>: DecodingProvider, EncodingProvider where DecodingSubject == Subject, EncodingSubject == Subject {
    
    associatedtype Subject
}
