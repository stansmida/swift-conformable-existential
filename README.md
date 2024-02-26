# SwiftConformableExistential

A set of Swift Macros designed to facilitate the conformance of existential types to
`Equatable`, `Hashable`, `Decodable`, `Encodable`, and `Codable`.


## Overview

Until Swift gains support for [extending existential types](https://github.com/apple/swift-evolution/blob/main/proposals/0335-existential-any.md#extending-existential-types),
they cannot satisfy generic constraints on their own.

```swift
protocol Drinkable: Hashable {}

// Is ill-formed, because `any Drinkable` does not conform to `Hashable`,
// despite the fact that every `Drinkable` instance does.
struct Foo: Hashable {
    let drinkable: any Drinkable
}
```

Overcoming this limitation requires extensive boilerplate code. This package offers a set of macros
that can be attached to your protocol to synthesize ready-to-use property wrappers over the existential
type of the annotated protocol. These wrappers act as proxies for the respective conformances.
```swift
import SwiftConformableExistential

@HashableExistential
protocol Drinkable: Hashable {}

// `HashableDrinkable` is a `Hashable` wrapper over `any Drinkable`,
// synthesized of the attached `@HashableExistential` macro,
// allowing the compiler to now synthesize the `Hashable` implementation for `Foo`.
struct Foo: Hashable {

    @HashableDrinkable
    var drinkable: any Drinkable
}
```

Alternatively, the wrappers can also be used on-the-fly, particularly in situations where
employing property wrappers is not suitable:

```swift
struct Tap: View {

    @State private var drinkable: any Drinkable = .smallBeer
    
    var body: some View {
        ...           
        .onChange(of: HashableDrinkable(drinkable)) { _, newValue in
            prepareForPouring(newValue.wrappedValue)
        }
    }
}
```

For more, see [the documentation](http://stansmida.github.io/swift-conformable-existential/documentation/swiftconformableexistential).
