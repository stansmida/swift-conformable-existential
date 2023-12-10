/// A private "marker" protocol that equatable variants of ConformableExistential
/// macro expansion types conform to.
/// It is used to compare different type of wrappers for value equality. For example it allows
/// `EquatableAnimal(wrappedValue: Cow()) == EquatableOptionalAnimal(wrappedValue: Cow())` and
/// results to `true`.
/// - Important: This type is part of the internal implementation of `ConformableExistential` package.
/// It is public due to technical requirements but is not intended for direct use by client code.
public protocol _ConformableExistentialEquatableSupport: Equatable {
    var _equatable: (any Equatable)? { get }
}

/// A private marker protocol that equatable and sequence variants of ConformableExistential
/// macro expansion types conform to.
/// It is used to compare different type of wrappers for value equality. For example it allows
/// `EquatableSequenceOfAnimal(wrappedValue: [Cow()]) == EquatableMutableSequenceOfAnimal(wrappedValue: [Cow()])`
/// and results to `true`.
/// - Important: This type is part of the internal implementation of `ConformableExistential` package.
/// It is public due to technical requirements but is not intended for direct use by client code.
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

    /// - Important: Two `_ConformableExistentialEquatableSequenceSupport`s are evaluated as equal
    /// if they have same sequence type and the sequences contain the same elements in the same order.
    /// The reason for this limitation is that we cannot directly compare concrete sequence types with
    /// their equal-to implementations, since they are not Equatable (their elements are existentials).
    /// In 99.999...% these sequences won't be unordered though. Typically, unordered sequences use `Hashable`
    /// elements to be formed, so unless someone comes with custom implementation of unordered sequence type
    /// that takes existentials, it will be fine. For the unordered sequences with existentail elements,
    /// you must extend expansion wrappers for sequences and provide your own `Equatable` implementation.
    @usableFromInline
    static internal func areSequencesOfEquatablesEqual<LHS: _ConformableExistentialEquatableSequenceSupport, RHS: _ConformableExistentialEquatableSequenceSupport>(lhs: LHS, rhs: RHS) -> Bool {
        guard LHS.Equatables.self == RHS.Equatables.self else {
            return false
        }
        if let lhsEquatables = lhs._sequenceOfEquatables, let rhsEquatables = rhs._sequenceOfEquatables {
            var lhsIterator = lhsEquatables.makeIterator()
            var rhsIterator = rhsEquatables.makeIterator()
            while true {
                switch (lhsIterator.next(), rhsIterator.next()) {
                    case (.some(let lhsElement), .some(let rhsElement)):
                        if !(lhsElement as! any Equatable).isEqual(to: (rhsElement as! any Equatable)) {
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
