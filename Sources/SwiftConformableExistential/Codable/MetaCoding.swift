/// A type that decodes meta information.
public protocol MetaDecoding<Meta> {
    associatedtype Meta
    static func decode(from decoder: Decoder) throws -> Meta
}

/// A type that encodes meta information.
public protocol MetaEncoding<Meta> {
    associatedtype Meta
    static func encode(_ meta: Meta, to encoder: Encoder) throws
}

// `public typealias MetaCoding = MetaDecoding & MetaEncoding` is ill-formed:
// 'Cannot specialize non-generic type 'MetaCoding' (aka 'MetaDecoding & MetaEncoding')'
//
// `public typealias MetaCoding<Meta> = MetaDecoding<Meta> & MetaEncoding<Meta>` is ill formed:
// When spelling `enum Foo: MetaCoding` then 'Reference to generic type 'MetaCoding' requires arguments in <...>'
// When spelling `enum Foo: MetaCoding<any Drinkable.Type>` then 'Cannot inherit from protocol type with generic argument 'MetaDecoding<any Drinkable.Type>''
public protocol MetaCoding<Meta>: MetaDecoding, MetaEncoding {}
