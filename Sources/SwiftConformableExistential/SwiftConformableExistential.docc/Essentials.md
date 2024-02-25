# Essentials

## Applying the macros

This package provides macros that synthesize property wrappers for the existential type
of an annotated protocol. Unlike the existential type itself, these wrappers do conform to 
the protocols they represent. These can be `Equatable`, `Hashable`, `Decodable`, `Encodable`,
and `Codable`, or any combination thereof. To specify the conformance of the synthesized wrappers,
choose the respective macro: 

- ``EquatableExistential(accessModifier:)``
- ``HashableExistential(accessModifier:)``
- ``DecodableExistential(accessModifier:)``
- ``EncodableExistential(accessModifier:)``
- ``CodableExistential(accessModifier:)``
- ``EquatableDecodableExistential(accessModifier:)``
- ``EquatableEncodableExistential(accessModifier:)``
- ``EquatableCodableExistential(accessModifier:)``
- ``HashableDecodableExistential(accessModifier:)``
- ``HashableEncodableExistential(accessModifier:)``
- ``HashableCodableExistential(accessModifier:)``

Apply a macro by attaching it to a protocol.

```swift
@HashableCodableExistential
protocol Drinkable: Hashable, Codable {
    var milliliters: Double { get }
}
```

> Warning: The annotated protocol must explicitly inherit from protocols in the annotation macro.
> For example:
> ```swift
> @HashableCodableExistential
> protocol Drinkable: Hashable, Codable {}
> ```
> It does not have to match the conformances exactly though:
> ```swift
> // Ok because `Hashable` implies `Equatable` 
> // and `Codable` implies `Encodable`.
> @EquatableEncodableExistential
> protocol Drinkable: Hashable, Codable {}
> ```

> Note: [Understand](<doc:DetailedDesign#Composited-conformances>) why multiple
conformances form a single composite wrapper.


## Synthesized property wrappers

Every applied macro synthesizes property wrappers for the existential type, conforming to the protocols
the macro specifies. They come in regular, mutable, optional, collection, and any combination thereof variants.
Specifically, each applied macro generates the following 8 wrapper variants:
- _regular_
- _mutable_
- _optional_
- _mutable optional_
- _collection_
- _mutable collection_
- _optional collection_
- _mutable optional collection_

The formula for synthesized wrapper name is `{conformance}{variant}{protocol name}`.
For instance, attaching `@HashableExistential` to `Drinkable` synthesizes these 8
property wrappers:
```swift
HashableDrinkable
HashableMutableDrinkable
HashableOptionalDrinkable
HashableSequenceOfDrinkable<T> where T: Sequence<any Drinkable>
HashableMutableOptionalDrinkable
HashableMutableSequenceOfDrinkable<T> where T: Sequence<any Drinkable>
HashableOptionalSequenceOfDrinkable<T> where T: Sequence<any Drinkable>
HashableMutableOptionalSequenceOfDrinkable<T> where T: Sequence<any Drinkable>
```

Collection variant wrappers are generic, allowing you to choose your specific collection type.

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


## Utilizing synthesized property wrappers

Every synthesized wrapper is `@propertyWrapper`. This enables the annotation of properties of
the existential type. This example also illustrates the significance of all variants:

```swift
// Mutable variants allows mutating,
// e.g. `container.mutableDrinkable = .doubleEspresso`
// in comparison to non-mutable `drinkable`.
//
// `TypeCoding` generic parameter is described further below
// in "Coding" section.
struct Container: Hashable, Codable {

    @HashableCodableDrinkable<DrinkableTypeCoding>
    var drinkable: any Drinkable

    @HashableCodableMutableDrinkable<DrinkableTypeCoding>
    var mutableDrinkable: any Drinkable

    @HashableCodableOptionalDrinkable<DrinkableTypeCoding>
    var optionalDrinkable: (any Drinkable)?

    @HashableCodableMutableOptionalDrinkable<DrinkableTypeCoding>
    var mutableOptionalDrinkable: (any Drinkable)?
    
    @HashableCodableRangeReplaceableCollectionOfDrinkable<[any Drinkable], DrinkableTypeCoding>
    var drinkables: [any Drinkable]

    @HashableCodableMutableRangeReplaceableCollectionOfDrinkable<[any Drinkable], DrinkableTypeCoding>
    var mutableDrinkables: [any Drinkable]

    @HashableCodableOptionalRangeReplaceableCollectionOfDrinkable<[any Drinkable], DrinkableTypeCoding>
    var optionalDrinkables: [any Drinkable]?

    @HashableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<[any Drinkable], DrinkableTypeCoding>
    var mutableOptionalDrinkables: [any Drinkable]?
}
```
This makes all the properties `Hashable` and `Codable`, allowing the compiler to synthesize `Hashable`
and `Codable` implementations for `Container`.

All the wrappers project `self`. This enables the use of projection when passing generic arguments:
```swift
let uniques = Set(container.$drinkables)
```

Alternatively, the wrappers can also be used on-the-fly, particularly in situations where employing
property wrappers is not suitable:

```swift
struct Tap: View {

    @State private var drinkable: any Drinkable = .smallBeer
    
    var body: some View {
        ...           
        .onChange(of: HashableCodableDrinkable<DrinkableTypeCoding>(drinkable)) { _, newValue in
            runAnimation(for: newValue.wrappedValue)
        }
    }

    private func submit() {
        do {
            let data = try encoder.encode(HashableCodableDrinkable<DrinkableTypeCoding>(drinkable))
            try client.push(data)
        } catch { ... }
    }
}
```
```swift
// `drinkalbes` in the scope are of `[any Drinkable]`
let drinkablesSet = Set(drinkables.map({ HashableDrinkable($0) }))
```

### Mitigating cumbersomeness and verbosity of synthesized wrappers

> Tip: With 11 macros available, each generating 8 wrappers to address all supported variants,
> the task of clearly identifying the conformance and variant of all 88 wrappers leads to
> arguably cumbersome naming. To maintain clarity while mitigating this complexity,
> once you're acquainted with their characteristics, you can simplify their usage with
> `typealias`, achieving more concise spelling:
> 
> ```swift
> typealias AnyDrinkables = HashableCodableRangeReplaceableCollectionOfDrinkable<[any Drinkable], DrinkableTypeCoding>
> // Or if you want to stick with just the type coding but not the collection type:
> typealias AnyDrinkables<T> = HashableCodableRangeReplaceableCollectionOfDrinkable<T, DrinkableTypeCoding> where T: RangeReplaceableCollection<any Drinkable>
> 
> @AnyDrinkables 
> var drinkables: [any Drinkable]
> 
> try encoder.encode(AnyDrinkables([.smallBeer]))
> ```

Applying multiple macros to a protocol is also allowed:
```swift
@EquatableExistential // use less verbose `EquatableDrinkable` in places with just `Equatable` generic constraint
@HashableCodableExistential 
protocol Drinkable: Hashable, Codable {}
```


## Coding

While hashing and evaluating equality of existentials can be done based on the wrapped existential
value itself, coding presents a fundamental challenge. Specifically, decoding from an external
representation becomes impossible without knowing the concrete type.

```swift
struct DecodableDrinkable: Decodable {

    let wrappedValue: any Drinkable

    init(from decoder: Decoder) throws {
        wrappedValue = // What type are we supposed to decode? 
    }
```

To decode an existential, resolving the concrete type from the external representation is required first.
The synthesized codable wrappers accomplish this via their `TypeDecoding` generic parameter.
Similarly, the `TypeEncoding` generic parameter is responsible for encoding the type information,
ensuring the value can be correctly decoded.

The most straightforward way to implement `TypeCoding` is by adopting ``ProtocolMetatypeRepresentable``.
This type is designed to facilitate conversion back and forth between a metatype and its custom codable representation.
It also includes coding key information, enabling the decoding and encoding of type information.

An example of implementing ``ProtocolMetatypeRepresentable`` for `Drinkable`:

```swift
enum DrinkableTypeCoding: String, ProtocolMetatypeRepresentable {

    case beer, espresso, water

    init?(_ type: any Drinkable.Type) {
        switch type {
            case is Beer.Type: self = .beer
            case is Espresso.Type: self = .espresso
            case is Water.Type: self = .water
            default: return nil
        }
    }

    static let codingKey = AdHocCodingKey(stringValue: "__type")

    var type: any Drinkable.Type {
        switch self {
            case .beer: Beer.self
            case .espresso: Espresso.self
            case .water: Water.self
        }
    }
}
```

```swift
// Tip: Sugar your DrinkableTypeCoding codable wrappers
typealias AnyDrinkables = HashableCodableRangeReplaceableCollectionOfDrinkable<[any Drinkable], DrinkableTypeCoding>

let data = try! encoder.encode(AnyDrinkables([Espresso(milliliters: 20.0), Water(milliliters: 250.0)]))
print(String(data: data, encoding: .utf8)!)
```
```json
[
  {
    "__type" : "espresso",
    "milliliters" : 20
  },
  {
    "__type" : "water",
    "milliliters" : 250
  }
]
```
```swift
let decoded = try! decoder.decode(AnyDrinkables.self, from: data)
print(decoded.wrappedValue) // [Espresso(milliliters: 20.0), Water(milliliters: 250.0)]
```

> Tip: Make your `DrinkableTypeCoding` statically exhaustive.
> ```swift
> protocol Drinkable {
>     ...
>     // Enforce every adopter to provide its `DrinkableTypeCoding`.
>     static var typeRepresentation: DrinkableTypeCoding { get }
>     ...
> }
> enum DrinkableTypeCoding: String, ProtocolMetatypeRepresentable {
>     ...
>     // Now, every Drinkable metatype has its compile-time representation.
>     init?(_ type: any Drinkable.Type) {
>         self = type.typeRepresentation
>     }
>     ...
> ```


### More abstract type coding strategies

``ProtocolMetatypeRepresentable`` is essentially a high-level API that conforms to ``MetaCoding``.
`TypeCoding` is specifically constrained to ``MetaCoding`` alone. If you need a more hands-on approach
to discovering types, or in representing them, conform your `TypeCoding` to just ``MetaCoding``
or ``MetaDecoding`` / ``MetaEncoding`` for one-way type coding, to implement your arbitrary conversion
between a protocol metatype and its external representation.


### Encoding nil values

If your external representation format specification requires `nil` values of optional
`(any Drinkable)?`, or `[any Drinkable]?` to encode explicitly as null values, you can configure
this behavior in your `TypeEncoding` via ``OptionalExistentialEncodingConfig``.

```swift
enum DrinkableTypeCoding: String, OptionalExistentialEncodingConfig, ProtocolMetatypeRepresentable {
    ...
    static let shouldEncodeNil = true
    ...
}
```
This configuration makes `HashableCodableOptionalDrinkable<DrinkableTypeCoding>(nil)` to explicitly encode
as `null`, as opposed to omitting the `nil` value during encoding.


## More info

- <doc:DetailedDesign>
