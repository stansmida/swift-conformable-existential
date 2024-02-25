import SwiftConformableExistential

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

// MARK: Type Coding

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

/// `DrinkableTypeCoding` copy but encodes nil.
enum DrinkableTypeCodingNilEncoding: String, ProtocolMetatypeRepresentable, OptionalExistentialEncodingConfig {

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
    static let shouldEncodeNil = true

    var type: any Drinkable.Type {
        switch self {
            case .beer: Beer.self
            case .espresso: Espresso.self
            case .water: Water.self
        }
    }
}
