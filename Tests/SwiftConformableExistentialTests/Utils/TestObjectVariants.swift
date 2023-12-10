import SwiftConformableExistential

// MARK: - Generator interfaces

private protocol InitializableWithDrinkable {
    init(wrappedValue: any Drinkable)
}

private protocol InitializableWithOptionalDrinkable {
    init(wrappedValue: (any Drinkable)?)
}

private protocol InitializableWithDrinkables<T> {
    associatedtype T: Sequence<any Drinkable>
    init(wrappedValue: T)
}

private protocol InitializableWithOptionalDrinkables<T> {
    associatedtype T: Sequence<any Drinkable>
    init(wrappedValue: T?)
}

protocol WrapsDrinkable {
    var wrappedValue: any Drinkable { get }
}

protocol WrapsOptionalDrinkable {
    var wrappedValue: (any Drinkable)? { get }
}

protocol WrapsDrinkables {
    associatedtype S: Sequence<any Drinkable>
    var wrappedValue: S { get }
}

protocol WrapsOptionalDrinkables {
    associatedtype S: Sequence<any Drinkable>
    var wrappedValue: S? { get }
}

// MARK: EquatableExistential
extension EquatableDrinkable: InitializableWithDrinkable {}
extension EquatableMutableDrinkable: InitializableWithDrinkable {}
extension EquatableOptionalDrinkable: InitializableWithOptionalDrinkable {}
extension EquatableSequenceOfDrinkable: InitializableWithDrinkables {}
extension EquatableMutableOptionalDrinkable: InitializableWithOptionalDrinkable {}
extension EquatableMutableSequenceOfDrinkable: InitializableWithDrinkables {}
extension EquatableOptionalSequenceOfDrinkable: InitializableWithOptionalDrinkables {}
extension EquatableMutableOptionalSequenceOfDrinkable: InitializableWithOptionalDrinkables {}
// MARK: HashableExistential
extension HashableDrinkable: InitializableWithDrinkable {}
extension HashableMutableDrinkable: InitializableWithDrinkable {}
extension HashableOptionalDrinkable: InitializableWithOptionalDrinkable {}
extension HashableSequenceOfDrinkable: InitializableWithDrinkables {}
extension HashableMutableOptionalDrinkable: InitializableWithOptionalDrinkable {}
extension HashableMutableSequenceOfDrinkable: InitializableWithDrinkables {}
extension HashableOptionalSequenceOfDrinkable: InitializableWithOptionalDrinkables {}
extension HashableMutableOptionalSequenceOfDrinkable: InitializableWithOptionalDrinkables {}
// MARK: DecodableExistential
extension DecodableDrinkable: InitializableWithDrinkable, WrapsDrinkable {}
extension DecodableMutableDrinkable: InitializableWithDrinkable, WrapsDrinkable {}
extension DecodableOptionalDrinkable: InitializableWithOptionalDrinkable, WrapsOptionalDrinkable {}
extension DecodableRangeReplaceableCollectionOfDrinkable: InitializableWithDrinkables, WrapsDrinkables {}
extension DecodableMutableOptionalDrinkable: InitializableWithOptionalDrinkable, WrapsOptionalDrinkable {}
extension DecodableMutableRangeReplaceableCollectionOfDrinkable: InitializableWithDrinkables, WrapsDrinkables {}
extension DecodableOptionalRangeReplaceableCollectionOfDrinkable: InitializableWithOptionalDrinkables, WrapsOptionalDrinkables {}
extension DecodableMutableOptionalRangeReplaceableCollectionOfDrinkable: InitializableWithOptionalDrinkables, WrapsOptionalDrinkables {}
// MARK: EncodableExistential
extension EncodableDrinkable: InitializableWithDrinkable {}
extension EncodableMutableDrinkable: InitializableWithDrinkable {}
extension EncodableOptionalDrinkable: InitializableWithOptionalDrinkable {}
extension EncodableSequenceOfDrinkable: InitializableWithDrinkables {}
extension EncodableMutableOptionalDrinkable: InitializableWithOptionalDrinkable {}
extension EncodableMutableSequenceOfDrinkable: InitializableWithDrinkables {}
extension EncodableOptionalSequenceOfDrinkable: InitializableWithOptionalDrinkables {}
extension EncodableMutableOptionalSequenceOfDrinkable: InitializableWithOptionalDrinkables {}
// MARK: CodableExistential
extension CodableDrinkable: InitializableWithDrinkable, WrapsDrinkable {}
extension CodableMutableDrinkable: InitializableWithDrinkable, WrapsDrinkable {}
extension CodableOptionalDrinkable: InitializableWithOptionalDrinkable, WrapsOptionalDrinkable {}
extension CodableRangeReplaceableCollectionOfDrinkable: InitializableWithDrinkables, WrapsDrinkables {}
extension CodableMutableOptionalDrinkable: InitializableWithOptionalDrinkable, WrapsOptionalDrinkable {}
extension CodableMutableRangeReplaceableCollectionOfDrinkable: InitializableWithDrinkables, WrapsDrinkables {}
extension CodableOptionalRangeReplaceableCollectionOfDrinkable: InitializableWithOptionalDrinkables, WrapsOptionalDrinkables {}
extension CodableMutableOptionalRangeReplaceableCollectionOfDrinkable: InitializableWithOptionalDrinkables, WrapsOptionalDrinkables {}
// MARK: EquatableDecodableExistential
extension EquatableDecodableDrinkable: InitializableWithDrinkable, WrapsDrinkable {}
extension EquatableDecodableMutableDrinkable: InitializableWithDrinkable, WrapsDrinkable {}
extension EquatableDecodableOptionalDrinkable: InitializableWithOptionalDrinkable, WrapsOptionalDrinkable {}
extension EquatableDecodableRangeReplaceableCollectionOfDrinkable: InitializableWithDrinkables, WrapsDrinkables {}
extension EquatableDecodableMutableOptionalDrinkable: InitializableWithOptionalDrinkable, WrapsOptionalDrinkable {}
extension EquatableDecodableMutableRangeReplaceableCollectionOfDrinkable: InitializableWithDrinkables, WrapsDrinkables {}
extension EquatableDecodableOptionalRangeReplaceableCollectionOfDrinkable: InitializableWithOptionalDrinkables, WrapsOptionalDrinkables {}
extension EquatableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable: InitializableWithOptionalDrinkables, WrapsOptionalDrinkables {}
// MARK: EquatableEncodableExistential
extension EquatableEncodableDrinkable: InitializableWithDrinkable {}
extension EquatableEncodableMutableDrinkable: InitializableWithDrinkable {}
extension EquatableEncodableOptionalDrinkable: InitializableWithOptionalDrinkable {}
extension EquatableEncodableSequenceOfDrinkable: InitializableWithDrinkables {}
extension EquatableEncodableMutableOptionalDrinkable: InitializableWithOptionalDrinkable {}
extension EquatableEncodableMutableSequenceOfDrinkable: InitializableWithDrinkables {}
extension EquatableEncodableOptionalSequenceOfDrinkable: InitializableWithOptionalDrinkables {}
extension EquatableEncodableMutableOptionalSequenceOfDrinkable: InitializableWithOptionalDrinkables {}
// MARK: EquatableCodableExistential
extension EquatableCodableDrinkable: InitializableWithDrinkable, WrapsDrinkable {}
extension EquatableCodableMutableDrinkable: InitializableWithDrinkable, WrapsDrinkable {}
extension EquatableCodableOptionalDrinkable: InitializableWithOptionalDrinkable, WrapsOptionalDrinkable {}
extension EquatableCodableRangeReplaceableCollectionOfDrinkable: InitializableWithDrinkables, WrapsDrinkables {}
extension EquatableCodableMutableOptionalDrinkable: InitializableWithOptionalDrinkable, WrapsOptionalDrinkable {}
extension EquatableCodableMutableRangeReplaceableCollectionOfDrinkable: InitializableWithDrinkables, WrapsDrinkables {}
extension EquatableCodableOptionalRangeReplaceableCollectionOfDrinkable: InitializableWithOptionalDrinkables, WrapsOptionalDrinkables {}
extension EquatableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable: InitializableWithOptionalDrinkables, WrapsOptionalDrinkables {}
// MARK: HashableDecodableExistential
extension HashableDecodableDrinkable: InitializableWithDrinkable, WrapsDrinkable {}
extension HashableDecodableMutableDrinkable: InitializableWithDrinkable, WrapsDrinkable {}
extension HashableDecodableOptionalDrinkable: InitializableWithOptionalDrinkable, WrapsOptionalDrinkable {}
extension HashableDecodableRangeReplaceableCollectionOfDrinkable: InitializableWithDrinkables, WrapsDrinkables {}
extension HashableDecodableMutableOptionalDrinkable: InitializableWithOptionalDrinkable, WrapsOptionalDrinkable {}
extension HashableDecodableMutableRangeReplaceableCollectionOfDrinkable: InitializableWithDrinkables, WrapsDrinkables {}
extension HashableDecodableOptionalRangeReplaceableCollectionOfDrinkable: InitializableWithOptionalDrinkables, WrapsOptionalDrinkables {}
extension HashableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable: InitializableWithOptionalDrinkables, WrapsOptionalDrinkables {}
// MARK: EncodableExistential
extension HashableEncodableDrinkable: InitializableWithDrinkable {}
extension HashableEncodableMutableDrinkable: InitializableWithDrinkable {}
extension HashableEncodableOptionalDrinkable: InitializableWithOptionalDrinkable {}
extension HashableEncodableSequenceOfDrinkable: InitializableWithDrinkables {}
extension HashableEncodableMutableOptionalDrinkable: InitializableWithOptionalDrinkable {}
extension HashableEncodableMutableSequenceOfDrinkable: InitializableWithDrinkables {}
extension HashableEncodableOptionalSequenceOfDrinkable: InitializableWithOptionalDrinkables {}
extension HashableEncodableMutableOptionalSequenceOfDrinkable: InitializableWithOptionalDrinkables {}
// MARK: CodableExistential
extension HashableCodableDrinkable: InitializableWithDrinkable, WrapsDrinkable {}
extension HashableCodableMutableDrinkable: InitializableWithDrinkable, WrapsDrinkable {}
extension HashableCodableOptionalDrinkable: InitializableWithOptionalDrinkable, WrapsOptionalDrinkable {}
extension HashableCodableRangeReplaceableCollectionOfDrinkable: InitializableWithDrinkables, WrapsDrinkables {}
extension HashableCodableMutableOptionalDrinkable: InitializableWithOptionalDrinkable, WrapsOptionalDrinkable {}
extension HashableCodableMutableRangeReplaceableCollectionOfDrinkable: InitializableWithDrinkables, WrapsDrinkables {}
extension HashableCodableOptionalRangeReplaceableCollectionOfDrinkable: InitializableWithOptionalDrinkables, WrapsOptionalDrinkables {}
extension HashableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable: InitializableWithOptionalDrinkables, WrapsOptionalDrinkables {}

// MARK: - Equatable generator

private typealias EquatableDrinkableWrapper = _ConformableExistentialEquatableSupport & InitializableWithDrinkable
private typealias EquatableOptionalDrinkableWrapper = _ConformableExistentialEquatableSupport & InitializableWithOptionalDrinkable
private typealias EquatableSequenceOfDrinkableWrapper<T: Sequence<any Drinkable>> = _ConformableExistentialEquatableSequenceSupport & InitializableWithDrinkables<T>
private typealias EquatableOptionalSequenceOfDrinkableWrapper<T: Sequence<any Drinkable>> = _ConformableExistentialEquatableSequenceSupport & InitializableWithOptionalDrinkables<T>

// MARK: All variants (that conform to equatable) sorted into on of 4 baskets (by wrapped value type).
// These are then used to generate values (by the 4 protocols declaring init) to be used for equality checks
// in 2 equatable categories (by the 2 protocols declaring equality).

private var equatableDrinkableWrappers: [any EquatableDrinkableWrapper.Type] = [
    EquatableDrinkable.self,
    EquatableMutableDrinkable.self,
    HashableDrinkable.self,
    HashableMutableDrinkable.self,
    EquatableDecodableDrinkable<DrinkableSimpleCoding>.self,
    EquatableDecodableMutableDrinkable<DrinkableSimpleCoding>.self,
    EquatableEncodableDrinkable<DrinkableSimpleCoding>.self,
    EquatableEncodableMutableDrinkable<DrinkableSimpleCoding>.self,
    EquatableCodableDrinkable<DrinkableSimpleCoding>.self,
    EquatableCodableMutableDrinkable<DrinkableSimpleCoding>.self,
    HashableDecodableDrinkable<DrinkableSimpleCoding>.self,
    HashableDecodableMutableDrinkable<DrinkableSimpleCoding>.self,
    HashableEncodableDrinkable<DrinkableSimpleCoding>.self,
    HashableEncodableMutableDrinkable<DrinkableSimpleCoding>.self,
    HashableCodableDrinkable<DrinkableSimpleCoding>.self,
    HashableCodableMutableDrinkable<DrinkableSimpleCoding>.self,
]

private let equatableOptionalDrinkableWrappers: [any EquatableOptionalDrinkableWrapper.Type] = [
    EquatableOptionalDrinkable.self,
    EquatableMutableOptionalDrinkable.self,
    HashableOptionalDrinkable.self,
    HashableMutableOptionalDrinkable.self,
    EquatableDecodableOptionalDrinkable<DrinkableSimpleCoding>.self,
    EquatableDecodableMutableOptionalDrinkable<DrinkableSimpleCoding>.self,
    EquatableEncodableOptionalDrinkable<DrinkableSimpleCoding>.self,
    EquatableEncodableMutableOptionalDrinkable<DrinkableSimpleCoding>.self,
    EquatableCodableOptionalDrinkable<DrinkableSimpleCoding>.self,
    EquatableCodableMutableOptionalDrinkable<DrinkableSimpleCoding>.self,
    HashableDecodableOptionalDrinkable<DrinkableSimpleCoding>.self,
    HashableDecodableMutableOptionalDrinkable<DrinkableSimpleCoding>.self,
    HashableEncodableOptionalDrinkable<DrinkableSimpleCoding>.self,
    HashableEncodableMutableOptionalDrinkable<DrinkableSimpleCoding>.self,
    HashableCodableOptionalDrinkable<DrinkableSimpleCoding>.self,
    HashableCodableMutableOptionalDrinkable<DrinkableSimpleCoding>.self,
]

private func equatableSequenceOfDrinkableWrappers<T: RangeReplaceableCollection<any Drinkable>>(of _: T.Type) -> [any EquatableSequenceOfDrinkableWrapper<T>.Type] {
    [
        EquatableSequenceOfDrinkable<T>.self,
        EquatableMutableSequenceOfDrinkable<T>.self,
        HashableSequenceOfDrinkable<T>.self,
        HashableMutableSequenceOfDrinkable<T>.self,
        EquatableDecodableRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        EquatableDecodableMutableRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        EquatableEncodableSequenceOfDrinkable<T, DrinkableSimpleCoding>.self,
        EquatableEncodableMutableSequenceOfDrinkable<T, DrinkableSimpleCoding>.self,
        EquatableCodableRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        EquatableCodableMutableRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        HashableDecodableRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        HashableDecodableMutableRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        HashableEncodableSequenceOfDrinkable<T, DrinkableSimpleCoding>.self,
        HashableEncodableMutableSequenceOfDrinkable<T, DrinkableSimpleCoding>.self,
        HashableCodableRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        HashableCodableMutableRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
    ]
}

private func equatableOptionalSequenceOfDrinkableWrapper<T: RangeReplaceableCollection<any Drinkable>>(of _: T.Type) -> [any EquatableOptionalSequenceOfDrinkableWrapper<T>.Type] {
    [
        EquatableOptionalSequenceOfDrinkable<T>.self,
        EquatableMutableOptionalSequenceOfDrinkable<T>.self,
        HashableOptionalSequenceOfDrinkable<T>.self,
        HashableMutableOptionalSequenceOfDrinkable<T>.self,
        EquatableDecodableOptionalRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        EquatableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        EquatableEncodableOptionalSequenceOfDrinkable<T, DrinkableSimpleCoding>.self,
        EquatableEncodableMutableOptionalSequenceOfDrinkable<T, DrinkableSimpleCoding>.self,
        EquatableCodableOptionalRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        EquatableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        HashableDecodableOptionalRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        HashableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        HashableEncodableOptionalSequenceOfDrinkable<T, DrinkableSimpleCoding>.self,
        HashableEncodableMutableOptionalSequenceOfDrinkable<T, DrinkableSimpleCoding>.self,
        HashableCodableOptionalRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
        HashableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<T, DrinkableSimpleCoding>.self,
    ]
}

/// Generate all conformers of `_ConformableExistentialEquatableSupport` with given value.
func equatablesOfDrinkable(value: (any Drinkable)?) -> [any _ConformableExistentialEquatableSupport] {
    var result = [any _ConformableExistentialEquatableSupport]()
    if let value {
        result.append(contentsOf: equatableDrinkableWrappers.map({ $0.init(wrappedValue: value) }))
    }
    result.append(contentsOf: equatableOptionalDrinkableWrappers.map({ $0.init(wrappedValue: value) }))
    return result
}

/// Generate all conformers of `_ConformableExistentialEquatableSequenceSupport` with given value.
func equatablesOfDrinkables<T: RangeReplaceableCollection<any Drinkable>>(value: T?) -> [any _ConformableExistentialEquatableSequenceSupport] {
    var result = [any _ConformableExistentialEquatableSequenceSupport]()
    if let value {
        result.append(contentsOf: equatableSequenceOfDrinkableWrappers(of: T.self)
            .map({ $0.init(wrappedValue: value) as any _ConformableExistentialEquatableSequenceSupport })
        )
    }
    result.append(contentsOf: equatableOptionalSequenceOfDrinkableWrapper(of: T.self)
        .map({ $0.init(wrappedValue: value) as any _ConformableExistentialEquatableSequenceSupport })
    )
    return result
}

// MARK: - Codable generator

private typealias DecodableSequenceOfDrinkableWrapper<T: RangeReplaceableCollection<any Drinkable>> = Decodable & InitializableWithDrinkables<T>
private typealias DecodableOptionalSequenceOfDrinkableWrapper<T: RangeReplaceableCollection<any Drinkable>> = Decodable & InitializableWithOptionalDrinkables<T>
private typealias EncodableSequenceOfDrinkableWrapper<T: RangeReplaceableCollection<any Drinkable>> = Encodable & InitializableWithDrinkables<T>
private typealias EncodableOptionalSequenceOfDrinkableWrapper<T: RangeReplaceableCollection<any Drinkable>> = Encodable & InitializableWithOptionalDrinkables<T>

private func decodableDrinkableWrappers<C: CodingProvider<any Drinkable>>(with _: C.Type) -> [any (Decodable & InitializableWithDrinkable).Type] {
    [
        DecodableDrinkable<C>.self,
        DecodableMutableDrinkable<C>.self,
        CodableDrinkable<C>.self,
        CodableMutableDrinkable<C>.self,
        EquatableDecodableDrinkable<C>.self,
        EquatableDecodableMutableDrinkable<C>.self,
        EquatableCodableDrinkable<C>.self,
        EquatableCodableMutableDrinkable<C>.self,
        HashableDecodableDrinkable<C>.self,
        HashableDecodableMutableDrinkable<C>.self,
        HashableCodableDrinkable<C>.self,
        HashableCodableMutableDrinkable<C>.self,
    ]
}

private func decodableOptionalDrinkableWrappers<C: CodingProvider<any Drinkable>>(with _: C.Type) -> [any (Decodable & InitializableWithOptionalDrinkable).Type] {
    [
        DecodableOptionalDrinkable<C>.self,
        DecodableMutableOptionalDrinkable<C>.self,
        CodableOptionalDrinkable<C>.self,
        CodableMutableOptionalDrinkable<C>.self,
        EquatableDecodableOptionalDrinkable<C>.self,
        EquatableDecodableMutableOptionalDrinkable<C>.self,
        EquatableCodableOptionalDrinkable<C>.self,
        EquatableCodableMutableOptionalDrinkable<C>.self,
        HashableDecodableOptionalDrinkable<C>.self,
        HashableDecodableMutableOptionalDrinkable<C>.self,
        HashableCodableOptionalDrinkable<C>.self,
        HashableCodableMutableOptionalDrinkable<C>.self,
    ]
}

private func decodableSequenceOfDrinkablesWrappers<S, C>(_: S.Type, with _: C.Type) -> [any DecodableSequenceOfDrinkableWrapper<S>.Type] where S: RangeReplaceableCollection<any Drinkable>, C: CodingProvider<any Drinkable> {
    [
        DecodableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        DecodableMutableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        CodableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        CodableMutableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        EquatableDecodableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        EquatableDecodableMutableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        EquatableCodableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        EquatableCodableMutableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        HashableDecodableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        HashableDecodableMutableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        HashableCodableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        HashableCodableMutableRangeReplaceableCollectionOfDrinkable<S, C>.self,
    ]
}

private func decodableOptionalSequenceOfDrinkablesWrappers<S, C>(_: S.Type, with _: C.Type) -> [any DecodableOptionalSequenceOfDrinkableWrapper<S>.Type] where S: RangeReplaceableCollection<any Drinkable>, C: CodingProvider<any Drinkable> {
    [
        DecodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        DecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        CodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        CodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        EquatableDecodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        EquatableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        EquatableCodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        EquatableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        HashableDecodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        HashableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        HashableCodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        HashableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
    ]
}

private func encodableDrinkableWrappers<C: CodingProvider<any Drinkable>>(with _: C.Type) -> [any (Encodable & InitializableWithDrinkable).Type] {
    [
        EncodableDrinkable<C>.self,
        EncodableMutableDrinkable<C>.self,
        CodableDrinkable<C>.self,
        CodableMutableDrinkable<C>.self,
        EquatableEncodableDrinkable<C>.self,
        EquatableEncodableMutableDrinkable<C>.self,
        EquatableCodableDrinkable<C>.self,
        EquatableCodableMutableDrinkable<C>.self,
        HashableEncodableDrinkable<C>.self,
        HashableEncodableMutableDrinkable<C>.self,
        HashableCodableDrinkable<C>.self,
        HashableCodableMutableDrinkable<C>.self,
    ]
}

private func encodableOptionalDrinkableWrappers<C: CodingProvider<any Drinkable>>(with _: C.Type) -> [any (Encodable & InitializableWithOptionalDrinkable).Type] {
    [
        EncodableOptionalDrinkable<C>.self,
        EncodableMutableOptionalDrinkable<C>.self,
        CodableOptionalDrinkable<C>.self,
        CodableMutableOptionalDrinkable<C>.self,
        EquatableEncodableOptionalDrinkable<C>.self,
        EquatableEncodableMutableOptionalDrinkable<C>.self,
        EquatableCodableOptionalDrinkable<C>.self,
        EquatableCodableMutableOptionalDrinkable<C>.self,
        HashableEncodableOptionalDrinkable<C>.self,
        HashableEncodableMutableOptionalDrinkable<C>.self,
        HashableCodableOptionalDrinkable<C>.self,
        HashableCodableMutableOptionalDrinkable<C>.self,
    ]
}

private func encodableSequenceOfDrinkablesWrappers<S, C>(_: S.Type, with _: C.Type) -> [any EncodableSequenceOfDrinkableWrapper<S>.Type] where S: RangeReplaceableCollection<any Drinkable>, C: CodingProvider<any Drinkable> {
    [
        EncodableSequenceOfDrinkable<S, C>.self,
        EncodableMutableSequenceOfDrinkable<S, C>.self,
        CodableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        CodableMutableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        EquatableEncodableSequenceOfDrinkable<S, C>.self,
        EquatableEncodableMutableSequenceOfDrinkable<S, C>.self,
        EquatableCodableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        EquatableCodableMutableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        HashableEncodableSequenceOfDrinkable<S, C>.self,
        HashableEncodableMutableSequenceOfDrinkable<S, C>.self,
        HashableCodableRangeReplaceableCollectionOfDrinkable<S, C>.self,
        HashableCodableMutableRangeReplaceableCollectionOfDrinkable<S, C>.self,
    ]
}

private func encodableOptionalSequenceOfDrinkablesWrappers<S, C>(_: S.Type, with _: C.Type) -> [any EncodableOptionalSequenceOfDrinkableWrapper<S>.Type] where S: RangeReplaceableCollection<any Drinkable>, C: CodingProvider<any Drinkable> {
    [
        EncodableOptionalSequenceOfDrinkable<S, C>.self,
        EncodableMutableOptionalSequenceOfDrinkable<S, C>.self,
        CodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        CodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        EquatableEncodableOptionalSequenceOfDrinkable<S, C>.self,
        EquatableEncodableMutableOptionalSequenceOfDrinkable<S, C>.self,
        EquatableCodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        EquatableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        HashableEncodableOptionalSequenceOfDrinkable<S, C>.self,
        HashableEncodableMutableOptionalSequenceOfDrinkable<S, C>.self,
        HashableCodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
        HashableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>.self,
    ]
}

struct DecodablesOfDrinkable<C>: Decodable where C: CodingProvider<any Drinkable> {

    init(_ drinkable: any Drinkable) {
        _d1 = DecodableDrinkable<C>(wrappedValue: drinkable)
        _d2 = DecodableMutableDrinkable<C>(wrappedValue: drinkable)
        _d3 = CodableDrinkable<C>(wrappedValue: drinkable)
        _d4 = CodableMutableDrinkable<C>(wrappedValue: drinkable)
        _d5 = EquatableDecodableDrinkable<C>(wrappedValue: drinkable)
        _d6 = EquatableDecodableMutableDrinkable<C>(wrappedValue: drinkable)
        _d7 = EquatableCodableDrinkable<C>(wrappedValue: drinkable)
        _d8 = EquatableCodableMutableDrinkable<C>(wrappedValue: drinkable)
        _d9 = HashableDecodableDrinkable<C>(wrappedValue: drinkable)
        _d10 = HashableDecodableMutableDrinkable<C>(wrappedValue: drinkable)
        _d11 = HashableCodableDrinkable<C>(wrappedValue: drinkable)
        _d12 = HashableCodableMutableDrinkable<C>(wrappedValue: drinkable)
    }

    @DecodableDrinkable<C> var d1: any Drinkable
    @DecodableMutableDrinkable<C> var d2: any Drinkable
    @CodableDrinkable<C> var d3: any Drinkable
    @CodableMutableDrinkable<C> var d4: any Drinkable
    @EquatableDecodableDrinkable<C> var d5: any Drinkable
    @EquatableDecodableMutableDrinkable<C> var d6: any Drinkable
    @EquatableCodableDrinkable<C> var d7: any Drinkable
    @EquatableCodableMutableDrinkable<C> var d8: any Drinkable
    @HashableDecodableDrinkable<C> var d9: any Drinkable
    @HashableDecodableMutableDrinkable<C> var d10: any Drinkable
    @HashableCodableDrinkable<C> var d11: any Drinkable
    @HashableCodableMutableDrinkable<C> var d12: any Drinkable
}

struct DecodablesOfOptionalDrinkable<C>: Decodable where C: CodingProvider<any Drinkable> {

    init(_ drinkable: (any Drinkable)?) {
        _d1 = DecodableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d2 = DecodableMutableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d3 = CodableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d4 = CodableMutableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d5 = EquatableDecodableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d6 = EquatableDecodableMutableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d7 = EquatableCodableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d8 = EquatableCodableMutableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d9 = HashableDecodableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d10 = HashableDecodableMutableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d11 = HashableCodableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d12 = HashableCodableMutableOptionalDrinkable<C>(wrappedValue: drinkable)
    }

    @DecodableOptionalDrinkable<C> var d1: (any Drinkable)?
    @DecodableMutableOptionalDrinkable<C> var d2: (any Drinkable)?
    @CodableOptionalDrinkable<C> var d3: (any Drinkable)?
    @CodableMutableOptionalDrinkable<C> var d4: (any Drinkable)?
    @EquatableDecodableOptionalDrinkable<C> var d5: (any Drinkable)?
    @EquatableDecodableMutableOptionalDrinkable<C> var d6: (any Drinkable)?
    @EquatableCodableOptionalDrinkable<C> var d7: (any Drinkable)?
    @EquatableCodableMutableOptionalDrinkable<C> var d8: (any Drinkable)?
    @HashableDecodableOptionalDrinkable<C> var d9: (any Drinkable)?
    @HashableDecodableMutableOptionalDrinkable<C> var d10: (any Drinkable)?
    @HashableCodableOptionalDrinkable<C> var d11: (any Drinkable)?
    @HashableCodableMutableOptionalDrinkable<C> var d12: (any Drinkable)?
}

struct DecodablesOfDrinkables<S, C>: Decodable where S: RangeReplaceableCollection<any Drinkable>, C: CodingProvider<any Drinkable> {

    init(_ drinkables: S) {
        _d1 = DecodableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d2 = DecodableMutableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d3 = CodableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d4 = CodableMutableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d5 = EquatableDecodableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d6 = EquatableDecodableMutableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d7 = EquatableCodableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d8 = EquatableCodableMutableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d9 = HashableDecodableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d10 = HashableDecodableMutableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d11 = HashableCodableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d12 = HashableCodableMutableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
    }

    @DecodableRangeReplaceableCollectionOfDrinkable<S, C> var d1: S
    @DecodableMutableRangeReplaceableCollectionOfDrinkable<S, C> var d2: S
    @CodableRangeReplaceableCollectionOfDrinkable<S, C> var d3: S
    @CodableMutableRangeReplaceableCollectionOfDrinkable<S, C> var d4: S
    @EquatableDecodableRangeReplaceableCollectionOfDrinkable<S, C> var d5: S
    @EquatableDecodableMutableRangeReplaceableCollectionOfDrinkable<S, C> var d6: S
    @EquatableCodableRangeReplaceableCollectionOfDrinkable<S, C> var d7: S
    @EquatableCodableMutableRangeReplaceableCollectionOfDrinkable<S, C> var d8: S
    @HashableDecodableRangeReplaceableCollectionOfDrinkable<S, C> var d9: S
    @HashableDecodableMutableRangeReplaceableCollectionOfDrinkable<S, C> var d10: S
    @HashableCodableRangeReplaceableCollectionOfDrinkable<S, C> var d11: S
    @HashableCodableMutableRangeReplaceableCollectionOfDrinkable<S, C> var d12: S
}

struct DecodablesOfOptionalDrinkables<S, C>: Decodable where S: RangeReplaceableCollection<any Drinkable>, C: CodingProvider<any Drinkable> {

    init(_ drinkables: S?) {
        _d1 = DecodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d2 = DecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d3 = CodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d4 = CodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d5 = EquatableDecodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d6 = EquatableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d7 = EquatableCodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d8 = EquatableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d9 = HashableDecodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d10 = HashableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d11 = HashableCodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d12 = HashableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
    }

    @DecodableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d1: S?
    @DecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d2: S?
    @CodableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d3: S?
    @CodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d4: S?
    @EquatableDecodableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d5: S?
    @EquatableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d6: S?
    @EquatableCodableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d7: S?
    @EquatableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d8: S?
    @HashableDecodableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d9: S?
    @HashableDecodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d10: S?
    @HashableCodableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d11: S?
    @HashableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d12: S?
}

struct EncodablesOfDrinkable<C>: Encodable where C: CodingProvider<any Drinkable> {

    init(_ drinkable: any Drinkable) {
        _d1 = EncodableDrinkable<C>(wrappedValue: drinkable)
        _d2 = EncodableMutableDrinkable<C>(wrappedValue: drinkable)
        _d3 = CodableDrinkable<C>(wrappedValue: drinkable)
        _d4 = CodableMutableDrinkable<C>(wrappedValue: drinkable)
        _d5 = EquatableEncodableDrinkable<C>(wrappedValue: drinkable)
        _d6 = EquatableEncodableMutableDrinkable<C>(wrappedValue: drinkable)
        _d7 = EquatableCodableDrinkable<C>(wrappedValue: drinkable)
        _d8 = EquatableCodableMutableDrinkable<C>(wrappedValue: drinkable)
        _d9 = HashableEncodableDrinkable<C>(wrappedValue: drinkable)
        _d10 = HashableEncodableMutableDrinkable<C>(wrappedValue: drinkable)
        _d11 = HashableCodableDrinkable<C>(wrappedValue: drinkable)
        _d12 = HashableCodableMutableDrinkable<C>(wrappedValue: drinkable)
    }

    @EncodableDrinkable<C> var d1: any Drinkable
    @EncodableMutableDrinkable<C> var d2: any Drinkable
    @CodableDrinkable<C> var d3: any Drinkable
    @CodableMutableDrinkable<C> var d4: any Drinkable
    @EquatableEncodableDrinkable<C> var d5: any Drinkable
    @EquatableEncodableMutableDrinkable<C> var d6: any Drinkable
    @EquatableCodableDrinkable<C> var d7: any Drinkable
    @EquatableCodableMutableDrinkable<C> var d8: any Drinkable
    @HashableEncodableDrinkable<C> var d9: any Drinkable
    @HashableEncodableMutableDrinkable<C> var d10: any Drinkable
    @HashableCodableDrinkable<C> var d11: any Drinkable
    @HashableCodableMutableDrinkable<C> var d12: any Drinkable
}

struct EncodablesOfOptionalDrinkable<C>: Encodable where C: CodingProvider<any Drinkable> {

    init(_ drinkable: (any Drinkable)?) {
        _d1 = EncodableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d2 = EncodableMutableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d3 = CodableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d4 = CodableMutableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d5 = EquatableEncodableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d6 = EquatableEncodableMutableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d7 = EquatableCodableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d8 = EquatableCodableMutableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d9 = HashableEncodableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d10 = HashableEncodableMutableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d11 = HashableCodableOptionalDrinkable<C>(wrappedValue: drinkable)
        _d12 = HashableCodableMutableOptionalDrinkable<C>(wrappedValue: drinkable)
    }

    @EncodableOptionalDrinkable<C> var d1: (any Drinkable)?
    @EncodableMutableOptionalDrinkable<C> var d2: (any Drinkable)?
    @CodableOptionalDrinkable<C> var d3: (any Drinkable)?
    @CodableMutableOptionalDrinkable<C> var d4: (any Drinkable)?
    @EquatableEncodableOptionalDrinkable<C> var d5: (any Drinkable)?
    @EquatableEncodableMutableOptionalDrinkable<C> var d6: (any Drinkable)?
    @EquatableCodableOptionalDrinkable<C> var d7: (any Drinkable)?
    @EquatableCodableMutableOptionalDrinkable<C> var d8: (any Drinkable)?
    @HashableEncodableOptionalDrinkable<C> var d9: (any Drinkable)?
    @HashableEncodableMutableOptionalDrinkable<C> var d10: (any Drinkable)?
    @HashableCodableOptionalDrinkable<C> var d11: (any Drinkable)?
    @HashableCodableMutableOptionalDrinkable<C> var d12: (any Drinkable)?
}

struct EncodablesOfDrinkables<S, C>: Encodable where S: RangeReplaceableCollection<any Drinkable>, C: CodingProvider<any Drinkable> {

    init(_ drinkables: S) {
        _d1 = EncodableSequenceOfDrinkable<S, C>(wrappedValue: drinkables)
        _d2 = EncodableMutableSequenceOfDrinkable<S, C>(wrappedValue: drinkables)
        _d3 = CodableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d4 = CodableMutableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d5 = EquatableEncodableSequenceOfDrinkable<S, C>(wrappedValue: drinkables)
        _d6 = EquatableEncodableMutableSequenceOfDrinkable<S, C>(wrappedValue: drinkables)
        _d7 = EquatableCodableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d8 = EquatableCodableMutableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d9 = HashableEncodableSequenceOfDrinkable<S, C>(wrappedValue: drinkables)
        _d10 = HashableEncodableMutableSequenceOfDrinkable<S, C>(wrappedValue: drinkables)
        _d11 = HashableCodableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d12 = HashableCodableMutableRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
    }

    @EncodableSequenceOfDrinkable<S, C> var d1: S
    @EncodableMutableSequenceOfDrinkable<S, C> var d2: S
    @CodableRangeReplaceableCollectionOfDrinkable<S, C> var d3: S
    @CodableMutableRangeReplaceableCollectionOfDrinkable<S, C> var d4: S
    @EquatableEncodableSequenceOfDrinkable<S, C> var d5: S
    @EquatableEncodableMutableSequenceOfDrinkable<S, C> var d6: S
    @EquatableCodableRangeReplaceableCollectionOfDrinkable<S, C> var d7: S
    @EquatableCodableMutableRangeReplaceableCollectionOfDrinkable<S, C> var d8: S
    @HashableEncodableSequenceOfDrinkable<S, C> var d9: S
    @HashableEncodableMutableSequenceOfDrinkable<S, C> var d10: S
    @HashableCodableRangeReplaceableCollectionOfDrinkable<S, C> var d11: S
    @HashableCodableMutableRangeReplaceableCollectionOfDrinkable<S, C> var d12: S
}

struct EncodablesOfOptionalDrinkables<S, C>: Encodable where S: RangeReplaceableCollection<any Drinkable>, C: CodingProvider<any Drinkable> {

    init(_ drinkables: S?) {
        _d1 = EncodableOptionalSequenceOfDrinkable<S, C>(wrappedValue: drinkables)
        _d2 = EncodableMutableOptionalSequenceOfDrinkable<S, C>(wrappedValue: drinkables)
        _d3 = CodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d4 = CodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d5 = EquatableEncodableOptionalSequenceOfDrinkable<S, C>(wrappedValue: drinkables)
        _d6 = EquatableEncodableMutableOptionalSequenceOfDrinkable<S, C>(wrappedValue: drinkables)
        _d7 = EquatableCodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d8 = EquatableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d9 = HashableEncodableOptionalSequenceOfDrinkable<S, C>(wrappedValue: drinkables)
        _d10 = HashableEncodableMutableOptionalSequenceOfDrinkable<S, C>(wrappedValue: drinkables)
        _d11 = HashableCodableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
        _d12 = HashableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C>(wrappedValue: drinkables)
    }

    @EncodableOptionalSequenceOfDrinkable<S, C> var d1: S?
    @EncodableMutableOptionalSequenceOfDrinkable<S, C> var d2: S?
    @CodableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d3: S?
    @CodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d4: S?
    @EquatableEncodableOptionalSequenceOfDrinkable<S, C> var d5: S?
    @EquatableEncodableMutableOptionalSequenceOfDrinkable<S, C> var d6: S?
    @EquatableCodableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d7: S?
    @EquatableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d8: S?
    @HashableEncodableOptionalSequenceOfDrinkable<S, C> var d9: S?
    @HashableEncodableMutableOptionalSequenceOfDrinkable<S, C> var d10: S?
    @HashableCodableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d11: S?
    @HashableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<S, C> var d12: S?
}

func decodablesOfDrinkable<C: CodingProvider<any Drinkable>>(
    optionalsOnly: Bool,
    with _: C.Type
) -> [any Decodable.Type] {
    var result = [any Decodable.Type]()
    if !optionalsOnly {
        result.append(contentsOf: decodableDrinkableWrappers(with: C.self))
    }
    result.append(contentsOf: decodableOptionalDrinkableWrappers(with: C.self))
    return result
}

func decodablesOfDrinkables<S, C>(
    of _: S.Type,
    optionalsOnly: Bool,
    with _: C.Type
) -> [any Decodable.Type] where S: RangeReplaceableCollection<any Drinkable>, C: CodingProvider<S.Element> {
    var result = [any Decodable.Type]()
    if !optionalsOnly {
        result.append(contentsOf: decodableSequenceOfDrinkablesWrappers(S.self, with: C.self))
    }
    result.append(contentsOf: decodableOptionalSequenceOfDrinkablesWrappers(S.self, with: C.self))
    return result
}

func encodablesOfDrinkable<C: CodingProvider<any Drinkable>>(
    value: (any Drinkable)?,
    with _: C.Type
) -> [any Encodable] {
    var result = [any Encodable]()
    if let value {
        result.append(contentsOf: encodableDrinkableWrappers(with: C.self).map({ $0.init(wrappedValue: value) }))
    }
    result.append(contentsOf: encodableOptionalDrinkableWrappers(with: C.self).map({ $0.init(wrappedValue: value) }))
    return result
}

func encodablesOfDrinkables<S, C>(
    value: S?,
    with _: C.Type
) -> [any Encodable] where S: RangeReplaceableCollection<any Drinkable>, C: CodingProvider<any Drinkable> {
    var result = [any Encodable]()
    if let value {
        result.append(contentsOf: encodableSequenceOfDrinkablesWrappers(S.self, with: C.self).map({ $0.init(wrappedValue: value) as any Encodable }))
    }
    result.append(contentsOf: encodableOptionalSequenceOfDrinkablesWrappers(S.self, with: C.self).map({ $0.init(wrappedValue: value) as any Encodable }))
    return result
}

/// `DrinkableSimpleCoding` copy but encodes nil.
struct DrinkableSimpleCodingNilEncoding: CodingProvider {

    private enum Error: Swift.Error {
        case unexpectedType(any Drinkable.Type)
        case unexpectedTypeKey(String)
    }

    static let shouldEncodeNil = true
    private static let typeCondingKey = AdHocCodingKey(stringValue: "__type")
    private static let expectedTypes: [String: any Drinkable.Type] = [
        "Water": Water.self,
        "Beer": Beer.self,
        "Espresso": Espresso.self,
    ]

    static func encode(_ value: any Drinkable, to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: AdHocCodingKey.self)
        guard 
            let type = expectedTypes.first(where: { $1 == type(of: value) })?.key
        else {
            throw Error.unexpectedType(type(of: value))
        }
        try container.encode(type, forKey: typeCondingKey)
        try value.encode(to: encoder)
    }

    static func decode(from decoder: Decoder) throws -> any Drinkable {
        let container = try decoder.container(keyedBy: AdHocCodingKey.self)
        let typeName = try container.decode(String.self, forKey: typeCondingKey)
        guard let type = expectedTypes[typeName] else {
            throw Error.unexpectedTypeKey(typeName)
        }
        return try type.init(from: decoder)
    }
}
