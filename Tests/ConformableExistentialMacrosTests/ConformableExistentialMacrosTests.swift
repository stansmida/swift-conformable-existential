import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(ConformableExistentialMacros)
import ConformableExistentialMacros
#endif

final class ConformableExistentialMacrosTests: XCTestCase {

    func testEquatableExistential() throws {
        #if canImport(ConformableExistentialMacros)
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
        #if canImport(ConformableExistentialMacros)
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
        #if canImport(ConformableExistentialMacros)
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
            struct DecodableDrinkable<Coding>: Decodable where Coding: DecodingProvider<any Drinkable> {
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    wrappedValue = try Coding.decode(from: decoder)
                }
            }

            @propertyWrapper
            struct DecodableMutableDrinkable<Coding>: Decodable where Coding: DecodingProvider<any Drinkable> {
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    wrappedValue = try Coding.decode(from: decoder)
                }
            }

            @propertyWrapper
            struct DecodableOptionalDrinkable<Coding>: Decodable, _OptionalExistentialDecodingSupport where Coding: DecodingProvider<any Drinkable> {
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
                        wrappedValue = try Coding.decode(from: decoder)
                    }
                }
            }

            @propertyWrapper
            struct DecodableRangeReplaceableCollectionOfDrinkable<T, Coding>: Decodable where T: RangeReplaceableCollection<any Drinkable>, Coding: DecodingProvider<any Drinkable> {
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
                        let element = try container.decode(DecodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
            }

            @propertyWrapper
            struct DecodableMutableOptionalDrinkable<Coding>: Decodable, _OptionalExistentialDecodingSupport where Coding: DecodingProvider<any Drinkable> {
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
                        wrappedValue = try Coding.decode(from: decoder)
                    }
                }
            }

            @propertyWrapper
            struct DecodableMutableRangeReplaceableCollectionOfDrinkable<T, Coding>: Decodable where T: RangeReplaceableCollection<any Drinkable>, Coding: DecodingProvider<any Drinkable> {
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
                        let element = try container.decode(DecodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
            }

            @propertyWrapper
            struct DecodableOptionalRangeReplaceableCollectionOfDrinkable<T, Coding>: Decodable, _OptionalExistentialDecodingSupport where T: RangeReplaceableCollection<any Drinkable>, Coding: DecodingProvider<any Drinkable> {
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
                        let element = try container.decode(DecodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                    }
                }
            }

            @propertyWrapper
            struct DecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, Coding>: Decodable, _OptionalExistentialDecodingSupport where T: RangeReplaceableCollection<any Drinkable>, Coding: DecodingProvider<any Drinkable> {
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
                        let element = try container.decode(DecodableDrinkable<Coding>.self).wrappedValue
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
        #if canImport(ConformableExistentialMacros)
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
            struct EncodableDrinkable<Coding>: Encodable where Coding: EncodingProvider<any Drinkable> {
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    try Coding.encode(wrappedValue, to: encoder)
                }
            }

            @propertyWrapper
            struct EncodableMutableDrinkable<Coding>: Encodable where Coding: EncodingProvider<any Drinkable> {
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    try Coding.encode(wrappedValue, to: encoder)
                }
            }

            @propertyWrapper
            struct EncodableOptionalDrinkable<Coding>: Encodable, _OptionalExistentialEncodingSupport where Coding: EncodingProvider<any Drinkable> {
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try Coding.encode(wrappedValue, to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            @propertyWrapper
            struct EncodableSequenceOfDrinkable<T, Coding>: Encodable where T: Sequence<any Drinkable>, Coding: EncodingProvider<any Drinkable> {
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: T
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(contentsOf: wrappedValue.lazy.map {
                            EncodableDrinkable<Coding>(wrappedValue: $0)
                        })
                }
            }

            @propertyWrapper
            struct EncodableMutableOptionalDrinkable<Coding>: Encodable, _OptionalExistentialEncodingSupport where Coding: EncodingProvider<any Drinkable> {
                init(wrappedValue: (any Drinkable)?) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: (any Drinkable)?
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try Coding.encode(wrappedValue, to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            @propertyWrapper
            struct EncodableMutableSequenceOfDrinkable<T, Coding>: Encodable where T: Sequence<any Drinkable>, Coding: EncodingProvider<any Drinkable> {
                init(wrappedValue: T) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: T
                var projectedValue: Self {
                    self
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(contentsOf: wrappedValue.lazy.map {
                            EncodableDrinkable<Coding>(wrappedValue: $0)
                        })
                }
            }

            @propertyWrapper
            struct EncodableOptionalSequenceOfDrinkable<T, Coding>: Encodable, _OptionalExistentialEncodingSupport where T: Sequence<any Drinkable>, Coding: EncodingProvider<any Drinkable> {
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
                        try container.encode(contentsOf: wrappedValue.lazy.map {
                                EncodableDrinkable<Coding>(wrappedValue: $0)
                            })
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            @propertyWrapper
            struct EncodableMutableOptionalSequenceOfDrinkable<T, Coding>: Encodable, _OptionalExistentialEncodingSupport where T: Sequence<any Drinkable>, Coding: EncodingProvider<any Drinkable> {
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
                        try container.encode(contentsOf: wrappedValue.lazy.map {
                                EncodableDrinkable<Coding>(wrappedValue: $0)
                            })
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
        #if canImport(ConformableExistentialMacros)
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
            struct CodableDrinkable<Coding>: Codable where Coding: CodingProvider<any Drinkable> {
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                let wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    wrappedValue = try Coding.decode(from: decoder)
                }
                func encode(to encoder: Encoder) throws {
                    try Coding.encode(wrappedValue, to: encoder)
                }
            }

            @propertyWrapper
            struct CodableMutableDrinkable<Coding>: Codable where Coding: CodingProvider<any Drinkable> {
                init(wrappedValue: any Drinkable) {
                    self.wrappedValue = wrappedValue
                }
                var wrappedValue: any Drinkable
                var projectedValue: Self {
                    self
                }
                init(from decoder: Decoder) throws {
                    wrappedValue = try Coding.decode(from: decoder)
                }
                func encode(to encoder: Encoder) throws {
                    try Coding.encode(wrappedValue, to: encoder)
                }
            }

            @propertyWrapper
            struct CodableOptionalDrinkable<Coding>: Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where Coding: CodingProvider<any Drinkable> {
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
                        wrappedValue = try Coding.decode(from: decoder)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try Coding.encode(wrappedValue, to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            @propertyWrapper
            struct CodableRangeReplaceableCollectionOfDrinkable<T, Coding>: Codable where T: RangeReplaceableCollection<any Drinkable>, Coding: CodingProvider<any Drinkable> {
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
                        let element = try container.decode(CodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(contentsOf: wrappedValue.lazy.map {
                            CodableDrinkable<Coding>(wrappedValue: $0)
                        })
                }
            }

            @propertyWrapper
            struct CodableMutableOptionalDrinkable<Coding>: Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where Coding: CodingProvider<any Drinkable> {
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
                        wrappedValue = try Coding.decode(from: decoder)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try Coding.encode(wrappedValue, to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            @propertyWrapper
            struct CodableMutableRangeReplaceableCollectionOfDrinkable<T, Coding>: Codable where T: RangeReplaceableCollection<any Drinkable>, Coding: CodingProvider<any Drinkable> {
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
                        let element = try container.decode(CodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(contentsOf: wrappedValue.lazy.map {
                            CodableDrinkable<Coding>(wrappedValue: $0)
                        })
                }
            }

            @propertyWrapper
            struct CodableOptionalRangeReplaceableCollectionOfDrinkable<T, Coding>: Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where T: RangeReplaceableCollection<any Drinkable>, Coding: CodingProvider<any Drinkable> {
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
                        let element = try container.decode(CodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(contentsOf: wrappedValue.lazy.map {
                                CodableDrinkable<Coding>(wrappedValue: $0)
                            })
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            @propertyWrapper
            struct CodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, Coding>: Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where T: RangeReplaceableCollection<any Drinkable>, Coding: CodingProvider<any Drinkable> {
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
                        let element = try container.decode(CodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(contentsOf: wrappedValue.lazy.map {
                                CodableDrinkable<Coding>(wrappedValue: $0)
                            })
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
        #if canImport(ConformableExistentialMacros)
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
            struct EquatableDecodableDrinkable<Coding>: _ConformableExistentialEquatableSupport, Decodable where Coding: DecodingProvider<any Drinkable> {
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
                    wrappedValue = try Coding.decode(from: decoder)
                }
            }

            @propertyWrapper
            struct EquatableDecodableMutableDrinkable<Coding>: _ConformableExistentialEquatableSupport, Decodable where Coding: DecodingProvider<any Drinkable> {
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
                    wrappedValue = try Coding.decode(from: decoder)
                }
            }

            @propertyWrapper
            struct EquatableDecodableOptionalDrinkable<Coding>: _ConformableExistentialEquatableSupport, Decodable, _OptionalExistentialDecodingSupport where Coding: DecodingProvider<any Drinkable> {
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
                        wrappedValue = try Coding.decode(from: decoder)
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableDecodableRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Decodable where T: RangeReplaceableCollection<any Drinkable>, Coding: DecodingProvider<any Drinkable> {
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
                        let element = try container.decode(EquatableDecodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
            }

            @propertyWrapper
            struct EquatableDecodableMutableOptionalDrinkable<Coding>: _ConformableExistentialEquatableSupport, Decodable, _OptionalExistentialDecodingSupport where Coding: DecodingProvider<any Drinkable> {
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
                        wrappedValue = try Coding.decode(from: decoder)
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableDecodableMutableRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Decodable where T: RangeReplaceableCollection<any Drinkable>, Coding: DecodingProvider<any Drinkable> {
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
                        let element = try container.decode(EquatableDecodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableDecodableOptionalRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Decodable, _OptionalExistentialDecodingSupport where T: RangeReplaceableCollection<any Drinkable>, Coding: DecodingProvider<any Drinkable> {
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
                        let element = try container.decode(EquatableDecodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Decodable, _OptionalExistentialDecodingSupport where T: RangeReplaceableCollection<any Drinkable>, Coding: DecodingProvider<any Drinkable> {
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
                        let element = try container.decode(EquatableDecodableDrinkable<Coding>.self).wrappedValue
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
        #if canImport(ConformableExistentialMacros)
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
            struct EquatableEncodableDrinkable<Coding>: _ConformableExistentialEquatableSupport, Encodable where Coding: EncodingProvider<any Drinkable> {
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
                    try Coding.encode(wrappedValue, to: encoder)
                }
            }

            @propertyWrapper
            struct EquatableEncodableMutableDrinkable<Coding>: _ConformableExistentialEquatableSupport, Encodable where Coding: EncodingProvider<any Drinkable> {
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
                    try Coding.encode(wrappedValue, to: encoder)
                }
            }

            @propertyWrapper
            struct EquatableEncodableOptionalDrinkable<Coding>: _ConformableExistentialEquatableSupport, Encodable, _OptionalExistentialEncodingSupport where Coding: EncodingProvider<any Drinkable> {
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
                        try Coding.encode(wrappedValue, to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableEncodableSequenceOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Encodable where T: Sequence<any Drinkable>, Coding: EncodingProvider<any Drinkable> {
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
                    try container.encode(contentsOf: wrappedValue.lazy.map {
                            EquatableEncodableDrinkable<Coding>(wrappedValue: $0)
                        })
                }
            }

            @propertyWrapper
            struct EquatableEncodableMutableOptionalDrinkable<Coding>: _ConformableExistentialEquatableSupport, Encodable, _OptionalExistentialEncodingSupport where Coding: EncodingProvider<any Drinkable> {
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
                        try Coding.encode(wrappedValue, to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableEncodableMutableSequenceOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Encodable where T: Sequence<any Drinkable>, Coding: EncodingProvider<any Drinkable> {
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
                    try container.encode(contentsOf: wrappedValue.lazy.map {
                            EquatableEncodableDrinkable<Coding>(wrappedValue: $0)
                        })
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableEncodableOptionalSequenceOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Encodable, _OptionalExistentialEncodingSupport where T: Sequence<any Drinkable>, Coding: EncodingProvider<any Drinkable> {
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
                        try container.encode(contentsOf: wrappedValue.lazy.map {
                                EquatableEncodableDrinkable<Coding>(wrappedValue: $0)
                            })
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableEncodableMutableOptionalSequenceOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Encodable, _OptionalExistentialEncodingSupport where T: Sequence<any Drinkable>, Coding: EncodingProvider<any Drinkable> {
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
                        try container.encode(contentsOf: wrappedValue.lazy.map {
                                EquatableEncodableDrinkable<Coding>(wrappedValue: $0)
                            })
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
        #if canImport(ConformableExistentialMacros)
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
            struct EquatableCodableDrinkable<Coding>: _ConformableExistentialEquatableSupport, Codable where Coding: CodingProvider<any Drinkable> {
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
                    wrappedValue = try Coding.decode(from: decoder)
                }
                func encode(to encoder: Encoder) throws {
                    try Coding.encode(wrappedValue, to: encoder)
                }
            }

            @propertyWrapper
            struct EquatableCodableMutableDrinkable<Coding>: _ConformableExistentialEquatableSupport, Codable where Coding: CodingProvider<any Drinkable> {
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
                    wrappedValue = try Coding.decode(from: decoder)
                }
                func encode(to encoder: Encoder) throws {
                    try Coding.encode(wrappedValue, to: encoder)
                }
            }

            @propertyWrapper
            struct EquatableCodableOptionalDrinkable<Coding>: _ConformableExistentialEquatableSupport, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where Coding: CodingProvider<any Drinkable> {
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
                        wrappedValue = try Coding.decode(from: decoder)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try Coding.encode(wrappedValue, to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableCodableRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Codable where T: RangeReplaceableCollection<any Drinkable>, Coding: CodingProvider<any Drinkable> {
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
                        let element = try container.decode(EquatableCodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(contentsOf: wrappedValue.lazy.map {
                            EquatableCodableDrinkable<Coding>(wrappedValue: $0)
                        })
                }
            }

            @propertyWrapper
            struct EquatableCodableMutableOptionalDrinkable<Coding>: _ConformableExistentialEquatableSupport, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where Coding: CodingProvider<any Drinkable> {
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
                        wrappedValue = try Coding.decode(from: decoder)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try Coding.encode(wrappedValue, to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableCodableMutableRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Codable where T: RangeReplaceableCollection<any Drinkable>, Coding: CodingProvider<any Drinkable> {
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
                        let element = try container.decode(EquatableCodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(contentsOf: wrappedValue.lazy.map {
                            EquatableCodableDrinkable<Coding>(wrappedValue: $0)
                        })
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableCodableOptionalRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where T: RangeReplaceableCollection<any Drinkable>, Coding: CodingProvider<any Drinkable> {
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
                        let element = try container.decode(EquatableCodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(contentsOf: wrappedValue.lazy.map {
                                EquatableCodableDrinkable<Coding>(wrappedValue: $0)
                            })
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct EquatableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where T: RangeReplaceableCollection<any Drinkable>, Coding: CodingProvider<any Drinkable> {
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
                        let element = try container.decode(EquatableCodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(contentsOf: wrappedValue.lazy.map {
                                EquatableCodableDrinkable<Coding>(wrappedValue: $0)
                            })
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
        #if canImport(ConformableExistentialMacros)
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
            struct HashableEncodableDrinkable<Coding>: _ConformableExistentialEquatableSupport, Hashable, Encodable where Coding: EncodingProvider<any Drinkable> {
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
                    try Coding.encode(wrappedValue, to: encoder)
                }
            }

            @propertyWrapper
            struct HashableEncodableMutableDrinkable<Coding>: _ConformableExistentialEquatableSupport, Hashable, Encodable where Coding: EncodingProvider<any Drinkable> {
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
                    try Coding.encode(wrappedValue, to: encoder)
                }
            }

            @propertyWrapper
            struct HashableEncodableOptionalDrinkable<Coding>: _ConformableExistentialEquatableSupport, Hashable, Encodable, _OptionalExistentialEncodingSupport where Coding: EncodingProvider<any Drinkable> {
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
                        try Coding.encode(wrappedValue, to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableEncodableSequenceOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Encodable where T: Sequence<any Drinkable>, Coding: EncodingProvider<any Drinkable> {
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
                    try container.encode(contentsOf: wrappedValue.lazy.map {
                            HashableEncodableDrinkable<Coding>(wrappedValue: $0)
                        })
                }
            }

            @propertyWrapper
            struct HashableEncodableMutableOptionalDrinkable<Coding>: _ConformableExistentialEquatableSupport, Hashable, Encodable, _OptionalExistentialEncodingSupport where Coding: EncodingProvider<any Drinkable> {
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
                        try Coding.encode(wrappedValue, to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableEncodableMutableSequenceOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Encodable where T: Sequence<any Drinkable>, Coding: EncodingProvider<any Drinkable> {
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
                    try container.encode(contentsOf: wrappedValue.lazy.map {
                            HashableEncodableDrinkable<Coding>(wrappedValue: $0)
                        })
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableEncodableOptionalSequenceOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Encodable, _OptionalExistentialEncodingSupport where T: Sequence<any Drinkable>, Coding: EncodingProvider<any Drinkable> {
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
                        try container.encode(contentsOf: wrappedValue.lazy.map {
                                HashableEncodableDrinkable<Coding>(wrappedValue: $0)
                            })
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableEncodableMutableOptionalSequenceOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Encodable, _OptionalExistentialEncodingSupport where T: Sequence<any Drinkable>, Coding: EncodingProvider<any Drinkable> {
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
                        try container.encode(contentsOf: wrappedValue.lazy.map {
                                HashableEncodableDrinkable<Coding>(wrappedValue: $0)
                            })
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
        #if canImport(ConformableExistentialMacros)
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
            struct HashableDecodableDrinkable<Coding>: _ConformableExistentialEquatableSupport, Hashable, Decodable where Coding: DecodingProvider<any Drinkable> {
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
                    wrappedValue = try Coding.decode(from: decoder)
                }
            }

            @propertyWrapper
            struct HashableDecodableMutableDrinkable<Coding>: _ConformableExistentialEquatableSupport, Hashable, Decodable where Coding: DecodingProvider<any Drinkable> {
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
                    wrappedValue = try Coding.decode(from: decoder)
                }
            }

            @propertyWrapper
            struct HashableDecodableOptionalDrinkable<Coding>: _ConformableExistentialEquatableSupport, Hashable, Decodable, _OptionalExistentialDecodingSupport where Coding: DecodingProvider<any Drinkable> {
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
                        wrappedValue = try Coding.decode(from: decoder)
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableDecodableRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Decodable where T: RangeReplaceableCollection<any Drinkable>, Coding: DecodingProvider<any Drinkable> {
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
                        let element = try container.decode(HashableDecodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
            }

            @propertyWrapper
            struct HashableDecodableMutableOptionalDrinkable<Coding>: _ConformableExistentialEquatableSupport, Hashable, Decodable, _OptionalExistentialDecodingSupport where Coding: DecodingProvider<any Drinkable> {
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
                        wrappedValue = try Coding.decode(from: decoder)
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableDecodableMutableRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Decodable where T: RangeReplaceableCollection<any Drinkable>, Coding: DecodingProvider<any Drinkable> {
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
                        let element = try container.decode(HashableDecodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableDecodableOptionalRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Decodable, _OptionalExistentialDecodingSupport where T: RangeReplaceableCollection<any Drinkable>, Coding: DecodingProvider<any Drinkable> {
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
                        let element = try container.decode(HashableDecodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Decodable, _OptionalExistentialDecodingSupport where T: RangeReplaceableCollection<any Drinkable>, Coding: DecodingProvider<any Drinkable> {
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
                        let element = try container.decode(HashableDecodableDrinkable<Coding>.self).wrappedValue
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
        #if canImport(ConformableExistentialMacros)
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
            struct HashableCodableDrinkable<Coding>: _ConformableExistentialEquatableSupport, Hashable, Codable where Coding: CodingProvider<any Drinkable> {
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
                    wrappedValue = try Coding.decode(from: decoder)
                }
                func encode(to encoder: Encoder) throws {
                    try Coding.encode(wrappedValue, to: encoder)
                }
            }

            @propertyWrapper
            struct HashableCodableMutableDrinkable<Coding>: _ConformableExistentialEquatableSupport, Hashable, Codable where Coding: CodingProvider<any Drinkable> {
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
                    wrappedValue = try Coding.decode(from: decoder)
                }
                func encode(to encoder: Encoder) throws {
                    try Coding.encode(wrappedValue, to: encoder)
                }
            }

            @propertyWrapper
            struct HashableCodableOptionalDrinkable<Coding>: _ConformableExistentialEquatableSupport, Hashable, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where Coding: CodingProvider<any Drinkable> {
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
                        wrappedValue = try Coding.decode(from: decoder)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try Coding.encode(wrappedValue, to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableCodableRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Codable where T: RangeReplaceableCollection<any Drinkable>, Coding: CodingProvider<any Drinkable> {
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
                        let element = try container.decode(HashableCodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(contentsOf: wrappedValue.lazy.map {
                            HashableCodableDrinkable<Coding>(wrappedValue: $0)
                        })
                }
            }

            @propertyWrapper
            struct HashableCodableMutableOptionalDrinkable<Coding>: _ConformableExistentialEquatableSupport, Hashable, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where Coding: CodingProvider<any Drinkable> {
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
                        wrappedValue = try Coding.decode(from: decoder)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        try Coding.encode(wrappedValue, to: encoder)
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableCodableMutableRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Codable where T: RangeReplaceableCollection<any Drinkable>, Coding: CodingProvider<any Drinkable> {
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
                        let element = try container.decode(HashableCodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                }
                func encode(to encoder: Encoder) throws {
                    var container = encoder.unkeyedContainer()
                    try container.encode(contentsOf: wrappedValue.lazy.map {
                            HashableCodableDrinkable<Coding>(wrappedValue: $0)
                        })
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableCodableOptionalRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where T: RangeReplaceableCollection<any Drinkable>, Coding: CodingProvider<any Drinkable> {
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
                        let element = try container.decode(HashableCodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(contentsOf: wrappedValue.lazy.map {
                                HashableCodableDrinkable<Coding>(wrappedValue: $0)
                            })
                    } else {
                        var container = encoder.singleValueContainer()
                        try container.encodeNil()
                    }
                }
            }

            /// - Important: `T` must be an ordered sequence in order to correctly compare for equality.
            /// See the documentation why and how to use your custom unordered sequences.
            @propertyWrapper
            struct HashableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, Coding>: _ConformableExistentialEquatableSequenceSupport, Hashable, Codable, _OptionalExistentialDecodingSupport, _OptionalExistentialEncodingSupport where T: RangeReplaceableCollection<any Drinkable>, Coding: CodingProvider<any Drinkable> {
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
                        let element = try container.decode(HashableCodableDrinkable<Coding>.self).wrappedValue
                        array.append(element)
                    }
                    wrappedValue = T(array)
                    }
                }
                func encode(to encoder: Encoder) throws {
                    if let wrappedValue {
                        var container = encoder.unkeyedContainer()
                        try container.encode(contentsOf: wrappedValue.lazy.map {
                                HashableCodableDrinkable<Coding>(wrappedValue: $0)
                            })
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
