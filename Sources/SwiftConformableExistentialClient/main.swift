import Foundation

typealias MutableOptionalDrinkables = HashableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<[any Drinkable], DrinkableType>

struct Container: Hashable, Codable {

    @HashableCodableMutableDrinkable<DrinkableType>
    var drinkable: any Drinkable

    @MutableOptionalDrinkables
    var drinkables: [any Drinkable]?
}

// MARK: -

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let decoder = JSONDecoder()

var c1 = Container(drinkable: .smallBeer)
c1.drinkable = Espresso(milliliters: 24)
c1.drinkables = [.smallBeer]

let encoded = try encoder.encode(c1)
print(String(data: encoded, encoding: .utf8)!)

let decoded = try decoder.decode(Container.self, from: encoded)

assert(decoded == c1)
assert(decoded.$drinkable == c1.$drinkable)
assert(decoded.$drinkables == c1.$drinkables)
