import SwiftConformableExistential

@HashableCodableExistential
protocol Drinkable: Hashable, Codable {

    static var type: DrinkableType { get }

    var milliliters: Double { get }
}

struct Beer: Drinkable {

    static let type = DrinkableType.beer

    let milliliters: Double
}

struct Espresso: Drinkable {

    static let type = DrinkableType.espresso

    let milliliters: Double
}

extension Drinkable where Self == Beer {
    static var smallBeer: Beer { Beer(milliliters: 300) }
}

enum DrinkableType: String, ProtocolMetatypeRepresentable {

    case beer, espresso

    init?(_ type: any Drinkable.Type) {
        self = type.type
    }

    static let codingKey = AdHocCodingKey(stringValue: "__type")

    var type: any Drinkable.Type {
        switch self {
            case .beer: Beer.self
            case .espresso: Espresso.self
        }
    }
}

