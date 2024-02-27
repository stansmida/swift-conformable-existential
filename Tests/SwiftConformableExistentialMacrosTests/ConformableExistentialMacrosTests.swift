import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(SwiftConformableExistentialMacros)
import SwiftConformableExistentialMacros
#endif

final class ConformableExistentialMacrosTests: XCTestCase {

    func testEquatableExistential() throws {
        #if canImport(SwiftConformableExistentialMacros)
        assertMacroExpansion(
            """
            @EquatableExistential
            protocol Drinkable: Equatable {
                var milliliters: Double { get }
            }
            """,
            expandedSource: """
            protocol Drinkable: Equatable {
                var milliliters: Double { get }
            }

            @propertyWrapper
            struct EquatableDrinkable: _ConformableExistentialEquatableSupport {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
            }

            @propertyWrapper
            struct EquatableMutableDrinkable: _ConformableExistentialEquatableSupport {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
            }

            @propertyWrapper
            struct EquatableOptionalDrinkable: _ConformableExistentialEquatableSupport {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableSequenceOfDrinkable<T>: _ConformableExistentialEquatableSequenceSupport where T: Sequence<any Drinkable> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
            }

            @propertyWrapper
            struct EquatableMutableOptionalDrinkable: _ConformableExistentialEquatableSupport {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableMutableSequenceOfDrinkable<T>: _ConformableExistentialEquatableSequenceSupport where T: Sequence<any Drinkable> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableOptionalSequenceOfDrinkable<T>: _ConformableExistentialEquatableSequenceSupport where T: Sequence<any Drinkable> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableMutableOptionalSequenceOfDrinkable<T>: _ConformableExistentialEquatableSequenceSupport where T: Sequence<any Drinkable> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
            }
            """,
            macros: ["EquatableExistential": EquatableExistential.self]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testHashableExistential() throws {
        #if canImport(SwiftConformableExistentialMacros)
        assertMacroExpansion(
            """
            @HashableExistential
            protocol Drinkable: Hashable {
                var milliliters: Double { get }
            }
            """,
            expandedSource: """
            protocol Drinkable: Hashable {
                var milliliters: Double { get }
            }

            @propertyWrapper
            struct HashableDrinkable: _ConformableExistentialEquatableSupport, Hashable {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                    hasher.combine(wrappedValue)
                }
            }

            @propertyWrapper
            struct HashableMutableDrinkable: _ConformableExistentialEquatableSupport, Hashable {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                    hasher.combine(wrappedValue)
                }
            }

            @propertyWrapper
            struct HashableOptionalDrinkable: _ConformableExistentialEquatableSupport, Hashable {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                        hasher.combine(wrappedValue)
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<any Drinkable>.self))
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableSequenceOfDrinkable<T>: _ConformableExistentialEquatableSequenceSupport, Hashable where T: Sequence<any Drinkable> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(T.self))
                    for element in wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: element)))
                        hasher.combine(element)
                    }
                }
            }

            @propertyWrapper
            struct HashableMutableOptionalDrinkable: _ConformableExistentialEquatableSupport, Hashable {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                        hasher.combine(wrappedValue)
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<any Drinkable>.self))
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableMutableSequenceOfDrinkable<T>: _ConformableExistentialEquatableSequenceSupport, Hashable where T: Sequence<any Drinkable> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(T.self))
                    for element in wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: element)))
                        hasher.combine(element)
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableOptionalSequenceOfDrinkable<T>: _ConformableExistentialEquatableSequenceSupport, Hashable where T: Sequence<any Drinkable> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(T.self))
                        for element in wrappedValue {
                            hasher.combine(ObjectIdentifier(type(of: element)))
                            hasher.combine(element)
                        }
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<T>.self))
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableMutableOptionalSequenceOfDrinkable<T>: _ConformableExistentialEquatableSequenceSupport, Hashable where T: Sequence<any Drinkable> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(T.self))
                        for element in wrappedValue {
                            hasher.combine(ObjectIdentifier(type(of: element)))
                            hasher.combine(element)
                        }
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<T>.self))
                    }
                }
            }
            """,
            macros: ["HashableExistential": HashableExistential.self]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testDecodableExistential() throws {
        #if canImport(SwiftConformableExistentialMacros)
        assertMacroExpansion(
            """
            @DecodableExistential
            protocol Drinkable: Decodable {
                var milliliters: Double { get }
            }
            """,
            expandedSource: """
            protocol Drinkable: Decodable {
                var milliliters: Double { get }
            }

            @propertyWrapper
            struct DecodableDrinkable<TypeCoding>: Decodable where TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    let type = try TypeCoding.decode(from: decoder)
                    wrappedValue = try type.init(from: decoder) as any Drinkable
                }
            }

            @propertyWrapper
            struct DecodableMutableDrinkable<TypeCoding>: Decodable where TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    let type = try TypeCoding.decode(from: decoder)
                    wrappedValue = try type.init(from: decoder) as any Drinkable
                }
            }

            @propertyWrapper
            struct DecodableOptionalDrinkable<TypeCoding>: Decodable, _OptionalExistentialDecodingSupport where TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        let type = try TypeCoding.decode(from: decoder)
                        wrappedValue = try type.init(from: decoder) as any Drinkable
                    }
                }
            }

            @propertyWrapper
            struct DecodableRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: Decodable where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    var container = try decoder.unkeyedContainer()
                    var array = Array<any Drinkable>()
                    if let count = container.count {
                        array.reserveCapacity(count)
                    }
                    while !container.isAtEnd {
                        let element = try container.decode(DecodableDrinkable<TypeCoding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
            }

            @propertyWrapper
            struct DecodableMutableOptionalDrinkable<TypeCoding>: Decodable, _OptionalExistentialDecodingSupport where TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        let type = try TypeCoding.decode(from: decoder)
                        wrappedValue = try type.init(from: decoder) as any Drinkable
                    }
                }
            }

            @propertyWrapper
            struct DecodableMutableRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: Decodable where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    var container = try decoder.unkeyedContainer()
                    var array = Array<any Drinkable>()
                    if let count = container.count {
                        array.reserveCapacity(count)
                    }
                    while !container.isAtEnd {
                        let element = try container.decode(DecodableDrinkable<TypeCoding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
            }

            @propertyWrapper
            struct DecodableOptionalRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: Decodable, _OptionalExistentialDecodingSupport where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        var container = try decoder.unkeyedContainer()
                        var array = Array<any Drinkable>()
                        if let count = container.count {
                            array.reserveCapacity(count)
                        }
                        while !container.isAtEnd {
                            let element = try container.decode(DecodableDrinkable<TypeCoding>.self).wrappedValue
                            array.append(element)
                        }
                        wrappedValue = T(array)
                    }
                }
            }

            @propertyWrapper
            struct DecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: Decodable, _OptionalExistentialDecodingSupport where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        var container = try decoder.unkeyedContainer()
                        var array = Array<any Drinkable>()
                        if let count = container.count {
                            array.reserveCapacity(count)
                        }
                        while !container.isAtEnd {
                            let element = try container.decode(DecodableDrinkable<TypeCoding>.self).wrappedValue
                            array.append(element)
                        }
                        wrappedValue = T(array)
                    }
                }
            }
            """,
            macros: ["DecodableExistential": DecodableExistential.self]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testEncodableExistential() throws {
        #if canImport(SwiftConformableExistentialMacros)
        assertMacroExpansion(
            """
            @EncodableExistential
            protocol Drinkable: Encodable {
                var milliliters: Double { get }
            }
            """,
            expandedSource: """
            protocol Drinkable: Encodable {
                var milliliters: Double { get }
            }

            @propertyWrapper
            struct EncodableDrinkable<TypeCoding>: Encodable where TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    try wrappedValue.encode(to: encoder)
                    try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                }
            }

            @propertyWrapper
            struct EncodableMutableDrinkable<TypeCoding>: Encodable where TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    try wrappedValue.encode(to: encoder)
                    try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                }
            }

            @propertyWrapper
            struct EncodableOptionalDrinkable<TypeCoding>: Encodable, _OptionalExistentialEncodingSupport where TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try wrappedValue.encode(to: encoder)
                        try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            @propertyWrapper
            struct EncodableSequenceOfDrinkable<T, TypeCoding>: Encodable where T: Sequence<any Drinkable>, TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(
                        contentsOf: wrappedValue.lazy.map({
                                EncodableDrinkable<TypeCoding>(wrappedValue: $0)
                            })
                    )
                }
            }

            @propertyWrapper
            struct EncodableMutableOptionalDrinkable<TypeCoding>: Encodable, _OptionalExistentialEncodingSupport where TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try wrappedValue.encode(to: encoder)
                        try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            @propertyWrapper
            struct EncodableMutableSequenceOfDrinkable<T, TypeCoding>: Encodable where T: Sequence<any Drinkable>, TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(
                        contentsOf: wrappedValue.lazy.map({
                                EncodableDrinkable<TypeCoding>(wrappedValue: $0)
                            })
                    )
                }
            }

            @propertyWrapper
            struct EncodableOptionalSequenceOfDrinkable<T, TypeCoding>: Encodable, _OptionalExistentialEncodingSupport where T: Sequence<any Drinkable>, TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(
                            contentsOf: wrappedValue.lazy.map({
                                    EncodableDrinkable<TypeCoding>(wrappedValue: $0)
                                })
                        )
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            @propertyWrapper
            struct EncodableMutableOptionalSequenceOfDrinkable<T, TypeCoding>: Encodable, _OptionalExistentialEncodingSupport where T: Sequence<any Drinkable>, TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(
                            contentsOf: wrappedValue.lazy.map({
                                    EncodableDrinkable<TypeCoding>(wrappedValue: $0)
                                })
                        )
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }
            """,
            macros: ["EncodableExistential": EncodableExistential.self]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testCodableExistential() throws {
        #if canImport(SwiftConformableExistentialMacros)
        assertMacroExpansion(
            """
            @CodableExistential
            protocol Drinkable: Codable {
                var milliliters: Double { get }
            }
            """,
            expandedSource: """
            protocol Drinkable: Codable {
                var milliliters: Double { get }
            }

            @propertyWrapper
            struct CodableDrinkable<TypeCoding>: Codable where TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    let type = try TypeCoding.decode(from: decoder)
                    wrappedValue = try type.init(from: decoder) as any Drinkable
                }
                func encode(to encoder: Encoder) throws {
                    try wrappedValue.encode(to: encoder)
                    try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                }
            }

            @propertyWrapper
            struct CodableMutableDrinkable<TypeCoding>: Codable where TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    let type = try TypeCoding.decode(from: decoder)
                    wrappedValue = try type.init(from: decoder) as any Drinkable
                }
                func encode(to encoder: Encoder) throws {
                    try wrappedValue.encode(to: encoder)
                    try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                }
            }

            @propertyWrapper
            struct CodableOptionalDrinkable<TypeCoding>: Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        let type = try TypeCoding.decode(from: decoder)
                        wrappedValue = try type.init(from: decoder) as any Drinkable
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try wrappedValue.encode(to: encoder)
                        try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            @propertyWrapper
            struct CodableRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: Codable where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    var container = try decoder.unkeyedContainer()
                    var array = Array<any Drinkable>()
                    if let count = container.count {
                        array.reserveCapacity(count)
                    }
                    while !container.isAtEnd {
                        let element = try container.decode(CodableDrinkable<TypeCoding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(
                        contentsOf: wrappedValue.lazy.map({
                                CodableDrinkable<TypeCoding>(wrappedValue: $0)
                            })
                    )
                }
            }

            @propertyWrapper
            struct CodableMutableOptionalDrinkable<TypeCoding>: Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        let type = try TypeCoding.decode(from: decoder)
                        wrappedValue = try type.init(from: decoder) as any Drinkable
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try wrappedValue.encode(to: encoder)
                        try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            @propertyWrapper
            struct CodableMutableRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: Codable where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    var container = try decoder.unkeyedContainer()
                    var array = Array<any Drinkable>()
                    if let count = container.count {
                        array.reserveCapacity(count)
                    }
                    while !container.isAtEnd {
                        let element = try container.decode(CodableDrinkable<TypeCoding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(
                        contentsOf: wrappedValue.lazy.map({
                                CodableDrinkable<TypeCoding>(wrappedValue: $0)
                            })
                    )
                }
            }

            @propertyWrapper
            struct CodableOptionalRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        var container = try decoder.unkeyedContainer()
                        var array = Array<any Drinkable>()
                        if let count = container.count {
                            array.reserveCapacity(count)
                        }
                        while !container.isAtEnd {
                            let element = try container.decode(CodableDrinkable<TypeCoding>.self).wrappedValue
                            array.append(element)
                        }
                        wrappedValue = T(array)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(
                            contentsOf: wrappedValue.lazy.map({
                                    CodableDrinkable<TypeCoding>(wrappedValue: $0)
                                })
                        )
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            @propertyWrapper
            struct CodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        var container = try decoder.unkeyedContainer()
                        var array = Array<any Drinkable>()
                        if let count = container.count {
                            array.reserveCapacity(count)
                        }
                        while !container.isAtEnd {
                            let element = try container.decode(CodableDrinkable<TypeCoding>.self).wrappedValue
                            array.append(element)
                        }
                        wrappedValue = T(array)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(
                            contentsOf: wrappedValue.lazy.map({
                                    CodableDrinkable<TypeCoding>(wrappedValue: $0)
                                })
                        )
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }
            """,
            macros: ["CodableExistential": CodableExistential.self]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testEquatableDecodableExistential() throws {
        #if canImport(SwiftConformableExistentialMacros)
        assertMacroExpansion(
            """
            @EquatableDecodableExistential
            protocol Drinkable: Equatable, Decodable {
                var milliliters: Double { get }
            }
            """,
            expandedSource: """
            protocol Drinkable: Equatable, Decodable {
                var milliliters: Double { get }
            }

            @propertyWrapper
            struct EquatableDecodableDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Decodable where TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    let type = try TypeCoding.decode(from: decoder)
                    wrappedValue = try type.init(from: decoder) as any Drinkable
                }
            }

            @propertyWrapper
            struct EquatableDecodableMutableDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Decodable where TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    let type = try TypeCoding.decode(from: decoder)
                    wrappedValue = try type.init(from: decoder) as any Drinkable
                }
            }

            @propertyWrapper
            struct EquatableDecodableOptionalDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Decodable, _OptionalExistentialDecodingSupport where TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        let type = try TypeCoding.decode(from: decoder)
                        wrappedValue = try type.init(from: decoder) as any Drinkable
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableDecodableRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Decodable where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    var container = try decoder.unkeyedContainer()
                    var array = Array<any Drinkable>()
                    if let count = container.count {
                        array.reserveCapacity(count)
                    }
                    while !container.isAtEnd {
                        let element = try container.decode(EquatableDecodableDrinkable<TypeCoding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
            }

            @propertyWrapper
            struct EquatableDecodableMutableOptionalDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Decodable, _OptionalExistentialDecodingSupport where TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        let type = try TypeCoding.decode(from: decoder)
                        wrappedValue = try type.init(from: decoder) as any Drinkable
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableDecodableMutableRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Decodable where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    var container = try decoder.unkeyedContainer()
                    var array = Array<any Drinkable>()
                    if let count = container.count {
                        array.reserveCapacity(count)
                    }
                    while !container.isAtEnd {
                        let element = try container.decode(EquatableDecodableDrinkable<TypeCoding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableDecodableOptionalRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Decodable, _OptionalExistentialDecodingSupport where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        var container = try decoder.unkeyedContainer()
                        var array = Array<any Drinkable>()
                        if let count = container.count {
                            array.reserveCapacity(count)
                        }
                        while !container.isAtEnd {
                            let element = try container.decode(EquatableDecodableDrinkable<TypeCoding>.self).wrappedValue
                            array.append(element)
                        }
                        wrappedValue = T(array)
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Decodable, _OptionalExistentialDecodingSupport where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        var container = try decoder.unkeyedContainer()
                        var array = Array<any Drinkable>()
                        if let count = container.count {
                            array.reserveCapacity(count)
                        }
                        while !container.isAtEnd {
                            let element = try container.decode(EquatableDecodableDrinkable<TypeCoding>.self).wrappedValue
                            array.append(element)
                        }
                        wrappedValue = T(array)
                    }
                }
            }
            """,
            macros: ["EquatableDecodableExistential": EquatableDecodableExistential.self]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testEquatableEncodableExistential() throws {
        #if canImport(SwiftConformableExistentialMacros)
        assertMacroExpansion(
            """
            @EquatableEncodableExistential
            protocol Drinkable: Equatable, Encodable {
                var milliliters: Double { get }
            }
            """,
            expandedSource: """
            protocol Drinkable: Equatable, Encodable {
                var milliliters: Double { get }
            }

            @propertyWrapper
            struct EquatableEncodableDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Encodable where TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func encode(to encoder: Encoder) throws {
                    try wrappedValue.encode(to: encoder)
                    try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                }
            }

            @propertyWrapper
            struct EquatableEncodableMutableDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Encodable where TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func encode(to encoder: Encoder) throws {
                    try wrappedValue.encode(to: encoder)
                    try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                }
            }

            @propertyWrapper
            struct EquatableEncodableOptionalDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Encodable, _OptionalExistentialEncodingSupport where TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try wrappedValue.encode(to: encoder)
                        try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableEncodableSequenceOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Encodable where T: Sequence<any Drinkable>, TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(
                        contentsOf: wrappedValue.lazy.map({
                                EquatableEncodableDrinkable<TypeCoding>(wrappedValue: $0)
                            })
                    )
                }
            }

            @propertyWrapper
            struct EquatableEncodableMutableOptionalDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Encodable, _OptionalExistentialEncodingSupport where TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try wrappedValue.encode(to: encoder)
                        try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableEncodableMutableSequenceOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Encodable where T: Sequence<any Drinkable>, TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(
                        contentsOf: wrappedValue.lazy.map({
                                EquatableEncodableDrinkable<TypeCoding>(wrappedValue: $0)
                            })
                    )
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableEncodableOptionalSequenceOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Encodable, _OptionalExistentialEncodingSupport where T: Sequence<any Drinkable>, TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(
                            contentsOf: wrappedValue.lazy.map({
                                    EquatableEncodableDrinkable<TypeCoding>(wrappedValue: $0)
                                })
                        )
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableEncodableMutableOptionalSequenceOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Encodable, _OptionalExistentialEncodingSupport where T: Sequence<any Drinkable>, TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(
                            contentsOf: wrappedValue.lazy.map({
                                    EquatableEncodableDrinkable<TypeCoding>(wrappedValue: $0)
                                })
                        )
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }
            """,
            macros: ["EquatableEncodableExistential": EquatableEncodableExistential.self]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testEquatableCodableExistential() throws {
        #if canImport(SwiftConformableExistentialMacros)
        assertMacroExpansion(
            """
            @EquatableCodableExistential
            protocol Drinkable: Equatable, Codable {
                var milliliters: Double { get }
            }
            """,
            expandedSource: """
            protocol Drinkable: Equatable, Codable {
                var milliliters: Double { get }
            }

            @propertyWrapper
            struct EquatableCodableDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Codable where TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    let type = try TypeCoding.decode(from: decoder)
                    wrappedValue = try type.init(from: decoder) as any Drinkable
                }
                func encode(to encoder: Encoder) throws {
                    try wrappedValue.encode(to: encoder)
                    try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                }
            }

            @propertyWrapper
            struct EquatableCodableMutableDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Codable where TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    let type = try TypeCoding.decode(from: decoder)
                    wrappedValue = try type.init(from: decoder) as any Drinkable
                }
                func encode(to encoder: Encoder) throws {
                    try wrappedValue.encode(to: encoder)
                    try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                }
            }

            @propertyWrapper
            struct EquatableCodableOptionalDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        let type = try TypeCoding.decode(from: decoder)
                        wrappedValue = try type.init(from: decoder) as any Drinkable
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try wrappedValue.encode(to: encoder)
                        try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableCodableRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Codable where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    var container = try decoder.unkeyedContainer()
                    var array = Array<any Drinkable>()
                    if let count = container.count {
                        array.reserveCapacity(count)
                    }
                    while !container.isAtEnd {
                        let element = try container.decode(EquatableCodableDrinkable<TypeCoding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(
                        contentsOf: wrappedValue.lazy.map({
                                EquatableCodableDrinkable<TypeCoding>(wrappedValue: $0)
                            })
                    )
                }
            }

            @propertyWrapper
            struct EquatableCodableMutableOptionalDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        let type = try TypeCoding.decode(from: decoder)
                        wrappedValue = try type.init(from: decoder) as any Drinkable
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try wrappedValue.encode(to: encoder)
                        try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableCodableMutableRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Codable where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    var container = try decoder.unkeyedContainer()
                    var array = Array<any Drinkable>()
                    if let count = container.count {
                        array.reserveCapacity(count)
                    }
                    while !container.isAtEnd {
                        let element = try container.decode(EquatableCodableDrinkable<TypeCoding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(
                        contentsOf: wrappedValue.lazy.map({
                                EquatableCodableDrinkable<TypeCoding>(wrappedValue: $0)
                            })
                    )
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableCodableOptionalRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        var container = try decoder.unkeyedContainer()
                        var array = Array<any Drinkable>()
                        if let count = container.count {
                            array.reserveCapacity(count)
                        }
                        while !container.isAtEnd {
                            let element = try container.decode(EquatableCodableDrinkable<TypeCoding>.self).wrappedValue
                            array.append(element)
                        }
                        wrappedValue = T(array)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(
                            contentsOf: wrappedValue.lazy.map({
                                    EquatableCodableDrinkable<TypeCoding>(wrappedValue: $0)
                                })
                        )
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        var container = try decoder.unkeyedContainer()
                        var array = Array<any Drinkable>()
                        if let count = container.count {
                            array.reserveCapacity(count)
                        }
                        while !container.isAtEnd {
                            let element = try container.decode(EquatableCodableDrinkable<TypeCoding>.self).wrappedValue
                            array.append(element)
                        }
                        wrappedValue = T(array)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(
                            contentsOf: wrappedValue.lazy.map({
                                    EquatableCodableDrinkable<TypeCoding>(wrappedValue: $0)
                                })
                        )
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }
            """,
            macros: ["EquatableCodableExistential": EquatableCodableExistential.self]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testHashableEncodableExistential() throws {
        #if canImport(SwiftConformableExistentialMacros)
        assertMacroExpansion(
            """
            @HashableEncodableExistential
            protocol Drinkable: Hashable, Encodable {
                var milliliters: Double { get }
            }
            """,
            expandedSource: """
            protocol Drinkable: Hashable, Encodable {
                var milliliters: Double { get }
            }

            @propertyWrapper
            struct HashableEncodableDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Hashable, Encodable where TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                    hasher.combine(wrappedValue)
                }
                func encode(to encoder: Encoder) throws {
                    try wrappedValue.encode(to: encoder)
                    try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                }
            }

            @propertyWrapper
            struct HashableEncodableMutableDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Hashable, Encodable where TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                    hasher.combine(wrappedValue)
                }
                func encode(to encoder: Encoder) throws {
                    try wrappedValue.encode(to: encoder)
                    try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                }
            }

            @propertyWrapper
            struct HashableEncodableOptionalDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Hashable, Encodable, _OptionalExistentialEncodingSupport where TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                        hasher.combine(wrappedValue)
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<any Drinkable>.self))
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try wrappedValue.encode(to: encoder)
                        try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableEncodableSequenceOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Encodable where T: Sequence<any Drinkable>, TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(T.self))
                    for element in wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: element)))
                        hasher.combine(element)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(
                        contentsOf: wrappedValue.lazy.map({
                                HashableEncodableDrinkable<TypeCoding>(wrappedValue: $0)
                            })
                    )
                }
            }

            @propertyWrapper
            struct HashableEncodableMutableOptionalDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Hashable, Encodable, _OptionalExistentialEncodingSupport where TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                        hasher.combine(wrappedValue)
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<any Drinkable>.self))
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try wrappedValue.encode(to: encoder)
                        try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableEncodableMutableSequenceOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Encodable where T: Sequence<any Drinkable>, TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(T.self))
                    for element in wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: element)))
                        hasher.combine(element)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(
                        contentsOf: wrappedValue.lazy.map({
                                HashableEncodableDrinkable<TypeCoding>(wrappedValue: $0)
                            })
                    )
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableEncodableOptionalSequenceOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Encodable, _OptionalExistentialEncodingSupport where T: Sequence<any Drinkable>, TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(T.self))
                        for element in wrappedValue {
                            hasher.combine(ObjectIdentifier(type(of: element)))
                            hasher.combine(element)
                        }
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<T>.self))
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(
                            contentsOf: wrappedValue.lazy.map({
                                    HashableEncodableDrinkable<TypeCoding>(wrappedValue: $0)
                                })
                        )
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableEncodableMutableOptionalSequenceOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Encodable, _OptionalExistentialEncodingSupport where T: Sequence<any Drinkable>, TypeCoding: MetaEncoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(T.self))
                        for element in wrappedValue {
                            hasher.combine(ObjectIdentifier(type(of: element)))
                            hasher.combine(element)
                        }
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<T>.self))
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(
                            contentsOf: wrappedValue.lazy.map({
                                    HashableEncodableDrinkable<TypeCoding>(wrappedValue: $0)
                                })
                        )
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }
            """,
            macros: ["HashableEncodableExistential": HashableEncodableExistential.self]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testHashableDecodableExistential() throws {
        #if canImport(SwiftConformableExistentialMacros)
        assertMacroExpansion(
            """
            @HashableDecodableExistential
            protocol Drinkable: Hashable, Decodable {
                var milliliters: Double { get }
            }
            """,
            expandedSource: """
            protocol Drinkable: Hashable, Decodable {
                var milliliters: Double { get }
            }

            @propertyWrapper
            struct HashableDecodableDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Hashable, Decodable where TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                    hasher.combine(wrappedValue)
                }
                init(from decoder: Decoder) throws {
                    let type = try TypeCoding.decode(from: decoder)
                    wrappedValue = try type.init(from: decoder) as any Drinkable
                }
            }

            @propertyWrapper
            struct HashableDecodableMutableDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Hashable, Decodable where TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                    hasher.combine(wrappedValue)
                }
                init(from decoder: Decoder) throws {
                    let type = try TypeCoding.decode(from: decoder)
                    wrappedValue = try type.init(from: decoder) as any Drinkable
                }
            }

            @propertyWrapper
            struct HashableDecodableOptionalDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Hashable, Decodable, _OptionalExistentialDecodingSupport where TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                        hasher.combine(wrappedValue)
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<any Drinkable>.self))
                    }
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        let type = try TypeCoding.decode(from: decoder)
                        wrappedValue = try type.init(from: decoder) as any Drinkable
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableDecodableRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Decodable where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(T.self))
                    for element in wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: element)))
                        hasher.combine(element)
                    }
                }
                init(from decoder: Decoder) throws {
                    var container = try decoder.unkeyedContainer()
                    var array = Array<any Drinkable>()
                    if let count = container.count {
                        array.reserveCapacity(count)
                    }
                    while !container.isAtEnd {
                        let element = try container.decode(HashableDecodableDrinkable<TypeCoding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
            }

            @propertyWrapper
            struct HashableDecodableMutableOptionalDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Hashable, Decodable, _OptionalExistentialDecodingSupport where TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                        hasher.combine(wrappedValue)
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<any Drinkable>.self))
                    }
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        let type = try TypeCoding.decode(from: decoder)
                        wrappedValue = try type.init(from: decoder) as any Drinkable
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableDecodableMutableRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Decodable where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(T.self))
                    for element in wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: element)))
                        hasher.combine(element)
                    }
                }
                init(from decoder: Decoder) throws {
                    var container = try decoder.unkeyedContainer()
                    var array = Array<any Drinkable>()
                    if let count = container.count {
                        array.reserveCapacity(count)
                    }
                    while !container.isAtEnd {
                        let element = try container.decode(HashableDecodableDrinkable<TypeCoding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableDecodableOptionalRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Decodable, _OptionalExistentialDecodingSupport where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(T.self))
                        for element in wrappedValue {
                            hasher.combine(ObjectIdentifier(type(of: element)))
                            hasher.combine(element)
                        }
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<T>.self))
                    }
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        var container = try decoder.unkeyedContainer()
                        var array = Array<any Drinkable>()
                        if let count = container.count {
                            array.reserveCapacity(count)
                        }
                        while !container.isAtEnd {
                            let element = try container.decode(HashableDecodableDrinkable<TypeCoding>.self).wrappedValue
                            array.append(element)
                        }
                        wrappedValue = T(array)
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Decodable, _OptionalExistentialDecodingSupport where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaDecoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(T.self))
                        for element in wrappedValue {
                            hasher.combine(ObjectIdentifier(type(of: element)))
                            hasher.combine(element)
                        }
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<T>.self))
                    }
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        var container = try decoder.unkeyedContainer()
                        var array = Array<any Drinkable>()
                        if let count = container.count {
                            array.reserveCapacity(count)
                        }
                        while !container.isAtEnd {
                            let element = try container.decode(HashableDecodableDrinkable<TypeCoding>.self).wrappedValue
                            array.append(element)
                        }
                        wrappedValue = T(array)
                    }
                }
            }
            """,
            macros: ["HashableDecodableExistential": HashableDecodableExistential.self]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testHashableCodableExistential() throws {
        #if canImport(SwiftConformableExistentialMacros)
        assertMacroExpansion(
            """
            @HashableCodableExistential
            protocol Drinkable: Hashable, Codable {
                var milliliters: Double { get }
            }
            """,
            expandedSource: """
            protocol Drinkable: Hashable, Codable {
                var milliliters: Double { get }
            }

            @propertyWrapper
            struct HashableCodableDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Hashable, Codable where TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                    hasher.combine(wrappedValue)
                }
                init(from decoder: Decoder) throws {
                    let type = try TypeCoding.decode(from: decoder)
                    wrappedValue = try type.init(from: decoder) as any Drinkable
                }
                func encode(to encoder: Encoder) throws {
                    try wrappedValue.encode(to: encoder)
                    try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                }
            }

            @propertyWrapper
            struct HashableCodableMutableDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Hashable, Codable where TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                    hasher.combine(wrappedValue)
                }
                init(from decoder: Decoder) throws {
                    let type = try TypeCoding.decode(from: decoder)
                    wrappedValue = try type.init(from: decoder) as any Drinkable
                }
                func encode(to encoder: Encoder) throws {
                    try wrappedValue.encode(to: encoder)
                    try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                }
            }

            @propertyWrapper
            struct HashableCodableOptionalDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Hashable, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                        hasher.combine(wrappedValue)
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<any Drinkable>.self))
                    }
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        let type = try TypeCoding.decode(from: decoder)
                        wrappedValue = try type.init(from: decoder) as any Drinkable
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try wrappedValue.encode(to: encoder)
                        try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableCodableRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Codable where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(T.self))
                    for element in wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: element)))
                        hasher.combine(element)
                    }
                }
                init(from decoder: Decoder) throws {
                    var container = try decoder.unkeyedContainer()
                    var array = Array<any Drinkable>()
                    if let count = container.count {
                        array.reserveCapacity(count)
                    }
                    while !container.isAtEnd {
                        let element = try container.decode(HashableCodableDrinkable<TypeCoding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(
                        contentsOf: wrappedValue.lazy.map({
                                HashableCodableDrinkable<TypeCoding>(wrappedValue: $0)
                            })
                    )
                }
            }

            @propertyWrapper
            struct HashableCodableMutableOptionalDrinkable<TypeCoding>: _ConformableExistentialEquatableSupport, Hashable, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                var _equatable: (any Equatable)? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: wrappedValue)))
                        hasher.combine(wrappedValue)
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<any Drinkable>.self))
                    }
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        let type = try TypeCoding.decode(from: decoder)
                        wrappedValue = try type.init(from: decoder) as any Drinkable
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try wrappedValue.encode(to: encoder)
                        try TypeCoding.encode(type(of: wrappedValue), to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableCodableMutableRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Codable where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    hasher.combine(ObjectIdentifier(T.self))
                    for element in wrappedValue {
                        hasher.combine(ObjectIdentifier(type(of: element)))
                        hasher.combine(element)
                    }
                }
                init(from decoder: Decoder) throws {
                    var container = try decoder.unkeyedContainer()
                    var array = Array<any Drinkable>()
                    if let count = container.count {
                        array.reserveCapacity(count)
                    }
                    while !container.isAtEnd {
                        let element = try container.decode(HashableCodableDrinkable<TypeCoding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(
                        contentsOf: wrappedValue.lazy.map({
                                HashableCodableDrinkable<TypeCoding>(wrappedValue: $0)
                            })
                    )
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableCodableOptionalRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(T.self))
                        for element in wrappedValue {
                            hasher.combine(ObjectIdentifier(type(of: element)))
                            hasher.combine(element)
                        }
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<T>.self))
                    }
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        var container = try decoder.unkeyedContainer()
                        var array = Array<any Drinkable>()
                        if let count = container.count {
                            array.reserveCapacity(count)
                        }
                        while !container.isAtEnd {
                            let element = try container.decode(HashableCodableDrinkable<TypeCoding>.self).wrappedValue
                            array.append(element)
                        }
                        wrappedValue = T(array)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(
                            contentsOf: wrappedValue.lazy.map({
                                    HashableCodableDrinkable<TypeCoding>(wrappedValue: $0)
                                })
                        )
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, TypeCoding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where T: RangeReplaceableCollection<any Drinkable>, TypeCoding: MetaCoding<any Drinkable.Type> {
                init(_ wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                init(wrappedValue: T?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T?
                var projectedValue: Self {
                    self
                }
                var _sequenceOfEquatables: T? {
                    wrappedValue
                }
                func hash(into hasher: inout Hasher) {
                    if let wrappedValue {
                        hasher.combine(ObjectIdentifier(T.self))
                        for element in wrappedValue {
                            hasher.combine(ObjectIdentifier(type(of: element)))
                            hasher.combine(element)
                        }
                    } else {
                        hasher.combine(ObjectIdentifier(Optional<T>.self))
                    }
                }
                init(from decoder: Decoder) throws {
                    if (try? decoder.singleValueContainer().decodeNil()) == true {
                        wrappedValue = nil
                    } else {
                        var container = try decoder.unkeyedContainer()
                        var array = Array<any Drinkable>()
                        if let count = container.count {
                            array.reserveCapacity(count)
                        }
                        while !container.isAtEnd {
                            let element = try container.decode(HashableCodableDrinkable<TypeCoding>.self).wrappedValue
                            array.append(element)
                        }
                        wrappedValue = T(array)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(
                            contentsOf: wrappedValue.lazy.map({
                                    HashableCodableDrinkable<TypeCoding>(wrappedValue: $0)
                                })
                        )
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }
            """,
            macros: ["HashableCodableExistential": HashableCodableExistential.self]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
