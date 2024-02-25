# Detailed design


## Equality

Equality is evaluated via `_ConformableExistentialEquatableSupport` and
`_ConformableExistentialEquatableSequenceSupport` internal protocols. Clients are
not intended to work with them directly, but the module use them to evaluate the equality of equatable 
wrappers that clients have spawned. It enables to compare "unrelated" types:
```swift
EquatableDrinkable(.smallBeer) == EquatableOptionalDrinkable(.smallBeer) // true
EquatableDrinkable(.smallBeer) == HashableCodableMutableOptionalDrinkable(.smallBeer) // true
EquatableSequenceOfDrinkable([.smallBeer, .glassOfWater]) == HashableOptionalSequenceOfDrinkable([.smallBeer, .glassOfWater]) // true
```


### Equality of collections

Two wrappers over a collection of existentials are evaluated as equal if they have the same sequence type
and if the sequences contain equal elements at respective index (have same order). Ideally, the wrapper would
be declared with an "OrderedSequence" generic constraint, but no such protocol exists. Since unordered
collections typically rely on `Hashable` to form indices (e.g., `Set`), and existentials cannot conform 
to `Hashable` (`Set<any Drinkable>` is ill-formed), it is very unlikely that this would become a problem
for clients. However, in such an unlikely case, clients can still resolve this issue by implementing
their own == operator on the wrapper that wraps the unordered collection.


## Rationales


### Composited conformances

The main reason for the existence of `HashableCodableExistential` (and other composite variants),
in addition to the standalone `HashableExistential` and `CodableExistential`, is the limitation in
the composition of property wrappers (
[1](https://github.com/apple/swift-evolution/blob/main/proposals/0258-property-wrappers.md#composition-of-property-wrappers),
[2](https://github.com/apple/swift-evolution/blob/main/proposals/0258-property-wrappers.md#composition)
).

```swift
struct Container: Hashable, Codable {

    // Is ill-formed `HashableDrinkable<CodableDrinkable<DrinkableTypeCoding>>` because
    // `CodableDrinkable` doesn't conform to `Hashable`. 
    @HashableDrinkable
    @CodableDrinkable<DrinkableTypeCoding>
    let drinkable: any Drinkable
}
```

This limitation leaves us with the only option - to satisfy both `Hashable` and `Codable` requirements
in a single wrapper.

```swift
struct Container: Hashable, Codable {

    @HashableCodableDrinkable<DrinkableTypeCoding>
    var drinkable: any Drinkable
}
```


### <TypeCoding> generic expression

A codable wrapper does not take a `TypeCoding` parameter in its initializer; instead, it is expressed
as a generic parameter. This allows compilation without forcing clients to initialize with arbitrarily
chosen "dumb" values.

```swift
// Wouldn't compile; perhaps once - https://forums.swift.org/t/allow-property-wrappers-with-multiple-arguments-to-defer-initialization-when-wrappedvalue-is-not-specified/38319
@HashableCodableDrinkable(with: DrinkableTypeCoding())
var drinkable: any Drinkable

// It would compile, but would force clients to initialize it with a fabricated value.
@HashableCodableDrinkable(with: DrinkableTypeCoding())
var drinkable: any Drinkable = .smallBeer

// The chosen expression compiles and allows `drinkable` to be defined in intialization.
@HashableCodableDrinkable<DrinkableTypeCoding>
var drinkable: any Drinkable
```
The static nature of `TypeCoding` generic parameter has also another benefit -
the statically-defined information protects clients from loading unexpected data, 
similar to the protection provided by NSSecureCoding ([1](https://developer.apple.com/documentation/foundation/codableconfiguration#overview)).


### `Sequence` and `RangeReplaceableCollection` wrapper type name components

To also support collections of existentials, the macros provide wrappers for these collections.
These wrappers are generic, allowing you to choose your specific collection type.

```swift
@HashableSequenceOfDrinkable
var drinkablesArray: [any Drinkable]

@HashableSequenceOfDrinkable
var drinkablesDeque: Deque<any Drinkable>
```

Decodable (and by implication, Codable) collection wrappers require the collection to be a `RangeReplaceableCollection`.
This is because their implementation depends on the `RangeReplaceableCollection.init<S>(_ elements: S)` constructor
when instantiating the collection from decoded elements. All the other wrappers utilize the most abstract 
`Sequence` protocol.

To clearly communicate the "collection variant" wrappers, and to respect the distinction between `Sequence`
and `RangeReplaceableCollection` generic constraints, I opted for this precise and formal notation.

Once clients become familiar with the nature of the collection wrappers, they can simplify the verbose spelling with
typealias sugars as described in <doc:Essentials#Mitigating-cumbersomeness-and-verbosity-of-synthesized-wrappers>.

#### Alternatives considered

- Express it by postfixig the protocol name with "s", e.g. `HashableDrinkables` instead of
`HashableSequenceOfDrinkable`. This would break the macro's `names: prefixed` declaration.
