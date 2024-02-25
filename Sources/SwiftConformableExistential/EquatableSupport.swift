/// - Important: This type is part of the internal implementation of ``SwiftConformableExistential`` module.
/// It is public due to technical requirements but is not intended for direct use by client code.
/// See more in <doc:DetailedDesign#Equality>.
public protocol _ConformableExistentialEquatableSupport: Equatable {
    var _equatable: (any Equatable)? { get }
}

/// - Important: This type is part of the internal implementation of ``SwiftConformableExistential`` module.
/// It is public due to technical requirements but is not intended for direct use by client code.
/// See more in <doc:DetailedDesign#Equality>.
public protocol _ConformableExistentialEquatableSequenceSupport: Equatable {
    associatedtype Equatables: Sequence
    var _sequenceOfEquatables: Equatables? { get }
}

public extension _ConformableExistentialEquatableSupport {

    @inlinable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs._equatable.isEqual(to: rhs._equatable)
    }

    @inlinable
    static func == (lhs: Self, rhs: some _ConformableExistentialEquatableSupport) -> Bool {
        lhs._equatable.isEqual(to: rhs._equatable)
    }

    @inlinable
    static func != (lhs: Self, rhs: some _ConformableExistentialEquatableSupport) -> Bool {
        !(lhs == rhs)
    }
}

public extension _ConformableExistentialEquatableSequenceSupport {

    @inlinable
    static func == (lhs: Self, rhs: Self) -> Bool {
        areSequencesOfEquatablesEqual(lhs: lhs, rhs: rhs)
    }

    @inlinable
    static func == <RHS: _ConformableExistentialEquatableSequenceSupport>(lhs: Self, rhs: RHS) -> Bool {
        areSequencesOfEquatablesEqual(lhs: lhs, rhs: rhs)
    }

    @inlinable
    static func != <RHS: _ConformableExistentialEquatableSequenceSupport>(lhs: Self, rhs: RHS) -> Bool {
        !(lhs == rhs)
    }

    /// - Important: Two wrappers over a collection of existentials are evaluated as equal if they have
    /// the same sequence type and if the sequences contain equal elements at respective index (have same order).
    /// See more in <doc:DetailedDesign#Equality-of-collections>.
    @usableFromInline
    static internal func areSequencesOfEquatablesEqual<LHS: _ConformableExistentialEquatableSequenceSupport, RHS: _ConformableExistentialEquatableSequenceSupport>(
        lhs: LHS,
        rhs: RHS
    ) -> Bool {
        guard LHS.Equatables.self == RHS.Equatables.self else {
            return false
        }
        if let lhsEquatables = lhs._sequenceOfEquatables, let rhsEquatables = rhs._sequenceOfEquatables {
            var lhsIterator = lhsEquatables.makeIterator()
            var rhsIterator = rhsEquatables.makeIterator()
            while true {
                switch (lhsIterator.next(), rhsIterator.next()) {
                    case (.some(let lhsElement), .some(let rhsElement)):
                        guard
                            let lhsEquatable = lhsElement as? any Equatable,
                            let rhsEquatable = rhsElement as? any Equatable,
                            lhsEquatable.isEqual(to: rhsEquatable)
                        else {
                            return false
                        }
                    case (.some, .none), (.none, .some):
                        return false
                    case (nil, nil):
                        return true
                }
            }
        } else {
            return lhs._sequenceOfEquatables == nil && rhs._sequenceOfEquatables == nil
        }
    }
}
