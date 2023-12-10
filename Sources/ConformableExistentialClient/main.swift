import ConformableExistential
import Foundation

@SimpleCodingProviding(expectedTypes: Beer.self, Espresso.self)
@HashableCodableExistential
protocol Drinkable: Hashable, Codable {
    var milliliters: Double { get }
}

struct Beer: Drinkable {
    let milliliters: Double
}

struct Espresso: Drinkable {
    let milliliters: Double
}

extension Drinkable where Self == Beer {
    static var smallBeer: Beer { Beer(milliliters: 300) }
}

typealias HashableCodableMutableOptionalDrinkables = HashableCodableMutableOptionalRangeReplaceableCollectionOfDrinkable<[any Drinkable], DrinkableSimpleCoding>

struct Container: Hashable, Codable {

    @HashableCodableMutableDrinkable<DrinkableSimpleCoding>
    var drinkable: any Drinkable

    @HashableCodableMutableOptionalDrinkables
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
