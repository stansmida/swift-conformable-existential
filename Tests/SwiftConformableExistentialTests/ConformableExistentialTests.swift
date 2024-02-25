import SwiftConformableExistential
import XCTest

final class ConformableExistentialTests: XCTestCase {

    // MARK: Hashable Tests

    func testEquatableAndHashable_whenSameExistentails_shouldEqual() throws {
        let lhs = equatablesOfDrinkable(value: .smallBeer)
        let rhs = equatablesOfDrinkable(value: .smallBeer)
        let c = assertEqualitiesInProductOf(lhs: lhs, rhs: rhs, shouldEqual: true)
        if c != 32 * 32 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) equality assertions with hash checking.")
    }

    func testEquatableAndHashable_whenBothNil_shouldEqual() throws {
        let lhs = equatablesOfDrinkable(value: nil)
        let rhs = equatablesOfDrinkable(value: nil)
        let c = assertEqualitiesInProductOf(lhs: lhs, rhs: rhs, shouldEqual: true)
        if c != 16 * 16 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) equality assertions with hash checking.")
    }

    func testEquatableAndHashable_whenOneNil_shouldNotEqual() throws {
        let lhs = equatablesOfDrinkable(value: nil)
        let rhs = equatablesOfDrinkable(value: .glassOfWater)
        let c = assertEqualitiesInProductOf(lhs: lhs, rhs: rhs, shouldEqual: false)
        if c != 16 * 32 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) equality assertions with hash checking.")
    }

    func testEquatableAndHashable_whenDifferentExistentialsWithSameEssentials_shouldNotEqual() throws {
        let lhs = equatablesOfDrinkable(value: Beer(milliliters: 5))
        let rhs = equatablesOfDrinkable(value: Water(milliliters: 5))
        let c = assertEqualitiesInProductOf(lhs: lhs, rhs: rhs, shouldEqual: false)
        if c != 32 * 32 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) equality assertions with hash checking.")
    }

    func testEquatableAndHashable_whenSameSequences_shouldEqual() {
        let lhs = equatablesOfDrinkables(value: [.glassOfWater, .doubleEspresso])
        let rhs = equatablesOfDrinkables(value: [.glassOfWater, .doubleEspresso])
        let c = assertEqualitiesInProductOf(lhs: lhs, rhs: rhs, shouldEqual: true)
        if c != 32 * 32 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) equality assertions with hash checking.")
    }

    func testEquatableAndHashable_whenEmptySequences_shouldEqual() {
        let lhs = equatablesOfDrinkables(value: [])
        let rhs = equatablesOfDrinkables(value: [])
        let c = assertEqualitiesInProductOf(lhs: lhs, rhs: rhs, shouldEqual: true)
        if c != 32 * 32 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) equality assertions with hash checking.")
    }

    func testEquatableAndHashable_whenNilSequences_shouldEqual() {
        let lhs = equatablesOfDrinkables(value: Array<any Drinkable>?.none)
        let rhs = equatablesOfDrinkables(value: Array<any Drinkable>?.none)
        let c = assertEqualitiesInProductOf(lhs: lhs, rhs: rhs, shouldEqual: true)
        if c != 16 * 16 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) equality assertions with hash checking.")
    }

    func testEquatableAndHashable_whenDifferentSequencesOfSameExistentials_shouldNotEqual() {
        let lhs = equatablesOfDrinkables(value: [.glassOfWater, .doubleEspresso])
        let rhs = equatablesOfDrinkables(value: [.glassOfWater, .doubleEspresso].prefix(.max))
        let c = assertEqualitiesInProductOf(lhs: lhs, rhs: rhs, shouldEqual: false)
        if c != 32 * 32 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) equality assertions with hash checking.")
    }

    func testEquatableAndHashable_whenDifferentElements_shouldNotEqual() {
        let lhs = equatablesOfDrinkables(value: [.glassOfWater, .doubleEspresso])
        let rhs0 = equatablesOfDrinkables(value: [.doubleEspresso, .glassOfWater])
        let rhs1 = equatablesOfDrinkables(value: [.glassOfWater])
        let rhs2 = equatablesOfDrinkables(value: [.glassOfWater, .doubleEspresso, .smallBeer])
        let rhs3 = equatablesOfDrinkables(value: [])
        let rhs4 = equatablesOfDrinkables(value: [.glassOfWater, Beer(milliliters: Espresso.doubleEspresso.milliliters)])
        let rhs5 = equatablesOfDrinkables(value: Array<any Drinkable>?.none)
        let c = assertEqualitiesInProductOf(lhs: lhs, rhs: rhs0, shouldEqual: false)
        + assertEqualitiesInProductOf(lhs: lhs, rhs: rhs1, shouldEqual: false)
        + assertEqualitiesInProductOf(lhs: lhs, rhs: rhs2, shouldEqual: false)
        + assertEqualitiesInProductOf(lhs: lhs, rhs: rhs3, shouldEqual: false)
        + assertEqualitiesInProductOf(lhs: lhs, rhs: rhs4, shouldEqual: false)
        + assertEqualitiesInProductOf(lhs: lhs, rhs: rhs5, shouldEqual: false)
        if c != 32 * 32 + 32 * 32 + 32 * 32 + 32 * 32 + 32 * 32 + 32 * 16 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) equality assertions with hash checking.")
    }

    // MARK: Codable Tests

    func testDecodable_whenNotNilDrinkableNotContained() throws {
        let decodables = decodablesOfDrinkable(optionalsOnly: false, with: DrinkableTypeCoding.self)
        var c = 0
        for decodableType in decodables {
            let decoded = try decoder.decode(decodableType, from: .smallBeer)
            XCTAssertEqual(ObjectIdentifier(type(of: decoded)), opened(decodableType))
            if let beer = (decoded as? any WrapsDrinkable)?.wrappedValue as? Beer {
                XCTAssertEqual(beer, .smallBeer)
            } else if let beer = (decoded as? any WrapsOptionalDrinkable)?.wrappedValue as? Beer {
                XCTAssertEqual(beer, .smallBeer)
            } else {
                XCTFail()
            }
            c += 1
        }
        if c != 24 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) decoding assertions.")
    }

    func testDecodable_whenNotNilDrinkablesNotContained() throws {
        let decodables = decodablesOfDrinkables(of: [any Drinkable].self, optionalsOnly: false, with: DrinkableTypeCoding.self)
        var c = 0
        for decodableType in decodables {
            let decoded = try decoder.decode(decodableType, from: .sequenceOfSmallBeerAndDoubleEspresso)
            XCTAssertEqual(ObjectIdentifier(type(of: decoded)), opened(decodableType))
            if let wrappers = decoded as? any WrapsDrinkables, case let s = wrappers.wrappedValue as any Sequence<any Drinkable>, let drinkables = s as? [any Drinkable] {
                XCTAssertEqual(EquatableSequenceOfDrinkable(wrappedValue: drinkables), EquatableSequenceOfDrinkable(wrappedValue: [Beer.smallBeer, Espresso.doubleEspresso]))
            } else if let wrappers = decoded as? any WrapsOptionalDrinkables, case let s = wrappers.wrappedValue as (any Sequence<any Drinkable>)?, let drinkables = s as? [any Drinkable] {
                XCTAssertEqual(EquatableSequenceOfDrinkable(wrappedValue: drinkables), EquatableSequenceOfDrinkable(wrappedValue: [Beer.smallBeer, Espresso.doubleEspresso]))
            } else {
                XCTFail()
            }
            c += 1
        }
        if c != 24 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) decoding assertions.")
    }

    func testDecodable_whenNilDrinkableNotContained() throws {
        let decodables = decodablesOfDrinkable(optionalsOnly: true, with: DrinkableTypeCoding.self)
        var c = 0
        for decodableType in decodables {
            let decoded = try decoder.decode(decodableType, from: .null)
            XCTAssertEqual(ObjectIdentifier(type(of: decoded)), opened(decodableType))
            if let drinkableWrapper = decoded as? any WrapsOptionalDrinkable {
                XCTAssertNil(drinkableWrapper.wrappedValue)
            } else {
                XCTFail()
            }
            c += 1
        }
        if c != 12 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) decoding assertions.")
    }

    func testDecodable_whenNilDrinkablesNotContained() throws {
        let decodables = decodablesOfDrinkables(of: [any Drinkable].self, optionalsOnly: true, with: DrinkableTypeCoding.self)
        var c = 0
        for decodableType in decodables {
            let decoded = try decoder.decode(decodableType, from: .null)
            XCTAssertEqual(ObjectIdentifier(type(of: decoded)), opened(decodableType))
            if let wrapper = decoded as? any WrapsOptionalDrinkables {
                XCTAssertNil(wrapper.wrappedValue as (any Sequence<any Drinkable>)?)
            } else {
                XCTFail()
            }
            c += 1
        }
        if c != 12 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) decoding assertions.")
    }

    func testDecodable_whenNotNilDrinkableInContainerOfNonOptionals() throws {
        let decoded = try decoder.decode(DecodablesOfDrinkable<DrinkableTypeCoding>.self, from: .glassOfWaterContained)
        XCTAssertEqual(String(reflecting: decoded), String(reflecting: DecodablesOfDrinkable<DrinkableTypeCoding>(.glassOfWater)))
    }

    func testDecodable_whenNotNilDrinkableInContainerOfOptionals() throws {
        let decoded = try decoder.decode(DecodablesOfOptionalDrinkable<DrinkableTypeCoding>.self, from: .glassOfWaterContained)
        XCTAssertEqual(String(reflecting: decoded), String(reflecting: DecodablesOfOptionalDrinkable<DrinkableTypeCoding>(.glassOfWater)))
    }

    func testDecodable_whenNilDrinkableInContainerOfOptionals() throws {
        let decoded = try decoder.decode(DecodablesOfOptionalDrinkable<DrinkableTypeCoding>.self, from: .emptyContainer)
        XCTAssertEqual(String(reflecting: decoded), String(reflecting: DecodablesOfOptionalDrinkable<DrinkableTypeCoding>(nil)))
    }

    func testDecodable_whenNilDrinkableInContainerOfOptionalsEncodingNil() throws {
        let decoded = try decoder.decode(DecodablesOfOptionalDrinkable<DrinkableTypeCoding>.self, from: .containerOfNils)
        XCTAssertEqual(String(reflecting: decoded), String(reflecting: DecodablesOfOptionalDrinkable<DrinkableTypeCoding>(nil)))
    }

    func testDecodable_whenNotNilDrinkablesInContainerOfNonOptionals() throws {
        let decoded = try decoder.decode(DecodablesOfDrinkables<[any Drinkable], DrinkableTypeCoding>.self, from: .sequenceOfGlassOfWaterAndSmallBeerContained)
        XCTAssertEqual(String(reflecting: decoded), String(reflecting: DecodablesOfDrinkables<[any Drinkable], DrinkableTypeCoding>([.glassOfWater, .smallBeer])))
    }

    func testDecodable_whenNotNilDrinkablesInContainerOfOptionals() throws {
        let decoded = try decoder.decode(DecodablesOfOptionalDrinkables<ArraySlice<any Drinkable>, DrinkableTypeCoding>.self, from: .sequenceOfGlassOfWaterAndSmallBeerContained)
        XCTAssertEqual(String(reflecting: decoded), String(reflecting: DecodablesOfOptionalDrinkables<ArraySlice<any Drinkable>, DrinkableTypeCoding>([.glassOfWater, .smallBeer])))
    }

    func testDecodable_whenNilDrinkablesInContainerOfOptionals() throws {
        let decoded = try decoder.decode(DecodablesOfOptionalDrinkables<[any Drinkable], DrinkableTypeCoding>.self, from: .emptyContainer)
        XCTAssertEqual(String(reflecting: decoded), String(reflecting: DecodablesOfOptionalDrinkables<[any Drinkable], DrinkableTypeCoding>(nil)))
    }

    func testDecodable_whenNilDrinkablesInContainerOfOptionalsEncodingNil() throws {
        let decoded = try decoder.decode(DecodablesOfOptionalDrinkables<[any Drinkable], DrinkableTypeCoding>.self, from: .containerOfNils)
        XCTAssertEqual(String(reflecting: decoded), String(reflecting: DecodablesOfOptionalDrinkables<[any Drinkable], DrinkableTypeCoding>(nil)))
    }

    func testEncodable_whenNotNilDrinkableNotContained() throws {
        let encodables = encodablesOfDrinkable(value: .smallBeer, with: DrinkableTypeCoding.self)
        var c = 0
        for encodable in encodables {
            let data = try encoder.encode(encodable)
            XCTAssertEqual(data, .smallBeer, "\(type(of: encodable))")
            c += 1
        }
        if c != 24 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) encoding assertions.")
    }

    func testEncodable_whenNotNilDrinkablesNotContained() throws {
        let encodables = encodablesOfDrinkables(value: [.smallBeer, .doubleEspresso], with: DrinkableTypeCoding.self)
        var c = 0
        for encodable in encodables {
            let data = try encoder.encode(encodable)
            XCTAssertEqual(data, .sequenceOfSmallBeerAndDoubleEspresso, "\(type(of: encodable))")
            c += 1
        }
        if c != 24 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) encoding assertions.")
    }

    func testEncodable_whenNilDrinkableNotContained() throws {
        let encodables = encodablesOfDrinkable(value: nil, with: DrinkableTypeCoding.self)
        var c = 0
        for encodable in encodables {
            let data = try encoder.encode(encodable)
            XCTAssertEqual(data, .null, "\(type(of: encodable))")
            c += 1
        }
        if c != 12 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) encoding assertions.")
    }

    func testEncodable_whenNilDrinkablesNotContained() throws {
        let encodables = encodablesOfDrinkables(value: ArraySlice<any Drinkable>?.none, with: DrinkableTypeCoding.self)
        var c = 0
        for encodable in encodables {
            let data = try encoder.encode(encodable)
            XCTAssertEqual(data, .null, "\(type(of: encodable))")
            c += 1
        }
        if c != 12 {
            XCTFail("Unexpected number of \(#function) assertions: \(c).")
        }
        print("\(#function) executed \(c) encoding assertions.")
    }

    func testEncodable_whenNotNilDrinkableInContainerOfNonOptionals() throws {
        let data = try encoder.encode(EncodablesOfDrinkable<DrinkableTypeCoding>(.glassOfWater))
        XCTAssertEqual(data, .glassOfWaterContained)
    }

    func testEncodable_whenNotNilDrinkableInContainerOfOptionals() throws {
        let data = try encoder.encode(EncodablesOfOptionalDrinkable<DrinkableTypeCoding>(.glassOfWater))
        XCTAssertEqual(data, .glassOfWaterContained)
    }

    func testEncodable_whenNilDrinkableInContainerOfOptionals() throws {
        let data = try encoder.encode(EncodablesOfOptionalDrinkable<DrinkableTypeCoding>(nil))
        XCTAssertEqual(data, .emptyContainer)
    }

    func testEncodable_whenNilDrinkableInContainerOfOptionalsEncodingNil() throws {
        let data = try encoder.encode(EncodablesOfOptionalDrinkable<DrinkableTypeCodingNilEncoding>(nil))
        XCTAssertEqual(data, .containerOfNils)
    }

    func testEncodable_whenNotNilDrinkablesInContainerOfNonOptionals() throws {
        let data = try encoder.encode(EncodablesOfDrinkables<[any Drinkable], DrinkableTypeCoding>([.glassOfWater, .smallBeer]))
        XCTAssertEqual(data, .sequenceOfGlassOfWaterAndSmallBeerContained)
    }

    func testEncodable_whenNotNilDrinkablesInContainerOfOptionals() throws {
        let data = try encoder.encode(EncodablesOfOptionalDrinkables<ArraySlice<any Drinkable>, DrinkableTypeCoding>([.glassOfWater, .smallBeer].prefix(.max)))
        XCTAssertEqual(data, .sequenceOfGlassOfWaterAndSmallBeerContained)
    }

    func testEncodable_whenNilDrinkablesInContainerOfOptionals() throws {
        let data = try encoder.encode(EncodablesOfOptionalDrinkables<[any Drinkable], DrinkableTypeCoding>(nil))
        XCTAssertEqual(data, .emptyContainer)
    }

    func testEncodable_whenNilDrinkablesInContainerOfOptionalsEncodingNil() throws {
        let data = try encoder.encode(EncodablesOfOptionalDrinkables<[any Drinkable], DrinkableTypeCodingNilEncoding>(nil))
        XCTAssertEqual(data, .containerOfNils)
    }
}

// MARK: Equatable Utils

private func assertEqualitiesInProductOf(
    lhs: some Sequence<any _ConformableExistentialEquatableSupport>,
    rhs: some Sequence<any _ConformableExistentialEquatableSupport>,
    shouldEqual: Bool,
    checkHash: Bool = true,
    printAssertion: Bool = false
) -> Int {
    var c = 0
    for lhsElement in lhs {
        for rhsElement in rhs {
            c += 1
            assertEquality(lhs: lhsElement, rhs: rhsElement, shouldEqual: shouldEqual, checkHash: checkHash, printAssertion: printAssertion)
            // assure symmetry
            assertEquality(lhs: rhsElement, rhs: lhsElement, shouldEqual: shouldEqual, checkHash: false, printAssertion: printAssertion)
        }
    }
    guard c > 0 else {
        preconditionFailure("Couldn't form product.")
    }
    return c
}

private func assertEqualitiesInProductOf(
    lhs: some Sequence<any _ConformableExistentialEquatableSequenceSupport>,
    rhs: some Sequence<any _ConformableExistentialEquatableSequenceSupport>,
    shouldEqual: Bool,
    checkHash: Bool = true,
    printAssertion: Bool = false
) -> Int {
    var c = 0
    for lhsElement in lhs {
        for rhsElement in rhs {
            c += 1
            assertEquality(lhs: lhsElement, rhs: rhsElement, shouldEqual: shouldEqual, checkHash: checkHash, printAssertion: printAssertion)
            // assure symmetry
            assertEquality(lhs: rhsElement, rhs: lhsElement, shouldEqual: shouldEqual, checkHash: false, printAssertion: printAssertion)
        }
    }
    guard c > 0 else {
        preconditionFailure("Couldn't form product.")
    }
    return c
}

private func assertEquality<LHS, RHS>(
    lhs: LHS,
    rhs: RHS,
    shouldEqual: Bool,
    checkHash: Bool,
    printAssertion: Bool
) where LHS: _ConformableExistentialEquatableSupport, RHS: _ConformableExistentialEquatableSupport {
    if shouldEqual {
        let message = "\(lhs) == \(rhs) -> expected true"
        if printAssertion { print(message) }
        XCTAssertTrue(lhs == rhs, message)
    } else {
        let message = "\(lhs) == \(rhs) -> expected false"
        if printAssertion { print(message) }
        XCTAssertFalse(lhs == rhs, message)
    }
    if let lhsHashable = lhs as? any Hashable, let rhsHashable = rhs as? any Hashable {
        if shouldEqual {
            let message = "\(lhsHashable) and \(rhsHashable) expected to have same hash."
            if printAssertion { print(message) }
            XCTAssertEqual(lhsHashable.hashValue, rhsHashable.hashValue, message)
        } else {
            let message = "\(lhsHashable) and \(rhsHashable) expected to have different hash."
            if printAssertion { print(message) }
            XCTAssertNotEqual(lhsHashable.hashValue, rhsHashable.hashValue, message)
        }
    }
}

private func assertEquality(
    lhs: some _ConformableExistentialEquatableSequenceSupport,
    rhs: some _ConformableExistentialEquatableSequenceSupport,
    shouldEqual: Bool,
    checkHash: Bool,
    printAssertion: Bool
) {
    if shouldEqual {
        let message = "\(lhs) == \(rhs) -> expected true"
        if printAssertion { print(message) }
        XCTAssertTrue(lhs == rhs, message)
    } else {
        let message = "\(lhs) == \(rhs) -> expected false"
        if printAssertion { print(message) }
        XCTAssertFalse(lhs == rhs, message)
    }
    if let lhsHashable = lhs as? any Hashable, let rhsHashable = rhs as? any Hashable {
        if shouldEqual {
            let message = "\(lhsHashable) and \(rhsHashable) expected to have same hash."
            if printAssertion { print(message) }
            XCTAssertEqual(lhsHashable.hashValue, rhsHashable.hashValue, message)
        } else {
            let message = "\(lhsHashable) and \(rhsHashable) expected to have different hash."
            if printAssertion { print(message) }
            XCTAssertNotEqual(lhsHashable.hashValue, rhsHashable.hashValue, message)
        }
    }
}

// MARK: Codable Utils

private let encoder = {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    return encoder
}()

private let decoder = JSONDecoder()

private func opened(_ type: (some Decodable).Type) -> ObjectIdentifier { ObjectIdentifier(type) }

private extension Data {

    static let null: Data =
        "null".data(using: .utf8)!

    static let emptyContainer: Data =
        """
        {

        }
        """.data(using: .utf8)!

    static let containerOfNils: Data =
        """
        {
          "d1" : null,
          "d2" : null,
          "d3" : null,
          "d4" : null,
          "d5" : null,
          "d6" : null,
          "d7" : null,
          "d8" : null,
          "d9" : null,
          "d10" : null,
          "d11" : null,
          "d12" : null
        }
        """.data(using: .utf8)!

    static let smallBeer: Data =
        """
        {
          "__type" : "beer",
          "milliliters" : 300
        }
        """.data(using: .utf8)!

    static let glassOfWaterContained: Data =
        """
        {
          "d1" : {
            "__type" : "water",
            "milliliters" : 250
          },
          "d2" : {
            "__type" : "water",
            "milliliters" : 250
          },
          "d3" : {
            "__type" : "water",
            "milliliters" : 250
          },
          "d4" : {
            "__type" : "water",
            "milliliters" : 250
          },
          "d5" : {
            "__type" : "water",
            "milliliters" : 250
          },
          "d6" : {
            "__type" : "water",
            "milliliters" : 250
          },
          "d7" : {
            "__type" : "water",
            "milliliters" : 250
          },
          "d8" : {
            "__type" : "water",
            "milliliters" : 250
          },
          "d9" : {
            "__type" : "water",
            "milliliters" : 250
          },
          "d10" : {
            "__type" : "water",
            "milliliters" : 250
          },
          "d11" : {
            "__type" : "water",
            "milliliters" : 250
          },
          "d12" : {
            "__type" : "water",
            "milliliters" : 250
          }
        }
        """.data(using: .utf8)!

    static let sequenceOfSmallBeerAndDoubleEspresso: Data =
        """
        [
          {
            "__type" : "beer",
            "milliliters" : 300
          },
          {
            "__type" : "espresso",
            "milliliters" : 50
          }
        ]
        """.data(using: .utf8)!

    static let sequenceOfGlassOfWaterAndSmallBeerContained: Data =
        """
        {
          "d1" : [
            {
              "__type" : "water",
              "milliliters" : 250
            },
            {
              "__type" : "beer",
              "milliliters" : 300
            }
          ],
          "d2" : [
            {
              "__type" : "water",
              "milliliters" : 250
            },
            {
              "__type" : "beer",
              "milliliters" : 300
            }
          ],
          "d3" : [
            {
              "__type" : "water",
              "milliliters" : 250
            },
            {
              "__type" : "beer",
              "milliliters" : 300
            }
          ],
          "d4" : [
            {
              "__type" : "water",
              "milliliters" : 250
            },
            {
              "__type" : "beer",
              "milliliters" : 300
            }
          ],
          "d5" : [
            {
              "__type" : "water",
              "milliliters" : 250
            },
            {
              "__type" : "beer",
              "milliliters" : 300
            }
          ],
          "d6" : [
            {
              "__type" : "water",
              "milliliters" : 250
            },
            {
              "__type" : "beer",
              "milliliters" : 300
            }
          ],
          "d7" : [
            {
              "__type" : "water",
              "milliliters" : 250
            },
            {
              "__type" : "beer",
              "milliliters" : 300
            }
          ],
          "d8" : [
            {
              "__type" : "water",
              "milliliters" : 250
            },
            {
              "__type" : "beer",
              "milliliters" : 300
            }
          ],
          "d9" : [
            {
              "__type" : "water",
              "milliliters" : 250
            },
            {
              "__type" : "beer",
              "milliliters" : 300
            }
          ],
          "d10" : [
            {
              "__type" : "water",
              "milliliters" : 250
            },
            {
              "__type" : "beer",
              "milliliters" : 300
            }
          ],
          "d11" : [
            {
              "__type" : "water",
              "milliliters" : 250
            },
            {
              "__type" : "beer",
              "milliliters" : 300
            }
          ],
          "d12" : [
            {
              "__type" : "water",
              "milliliters" : 250
            },
            {
              "__type" : "beer",
              "milliliters" : 300
            }
          ]
        }
        """.data(using: .utf8)!
}
