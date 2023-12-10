import ConformableExistential

@SimpleCodingProviding(expectedTypes: Water.self, Beer.self, Espresso.self)
// Spawn every possible conformance and variant permutation.
@EquatableExistential
@HashableExistential
@DecodableExistential
@EncodableExistential
@CodableExistential
@EquatableDecodableExistential
@EquatableEncodableExistential
@EquatableCodableExistential
@HashableEncodableExistential
@HashableDecodableExistential
@HashableCodableExistential
protocol Drinkable: Codable, Hashable {
    var milliliters: Double { get }
}

// MARK: Conformers

struct Water: Drinkable {
    let milliliters: Double
}

struct Beer: Drinkable {
    let milliliters: Double
}

struct Espresso: Drinkable {
    let milliliters: Double
}

// MARK: Conveniences

extension Drinkable where Self == Water {
    static var glassOfWater: Water { Water(milliliters: 250) }
}

extension Drinkable where Self == Beer {
    static var smallBeer: Beer { Beer(milliliters: 300) }
}

extension Drinkable where Self == Espresso {
    static var doubleEspresso: Espresso { Espresso(milliliters: 50) }
}
