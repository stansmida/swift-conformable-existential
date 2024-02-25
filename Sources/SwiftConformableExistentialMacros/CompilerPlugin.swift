import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct ConformableExistentialPlugin: CompilerPlugin {

    let providingMacros: [Macro.Type] = [
        EquatableExistential.self,
        HashableExistential.self,
        DecodableExistential.self,
        EncodableExistential.self,
        CodableExistential.self,
        EquatableDecodableExistential.self,
        EquatableEncodableExistential.self,
        EquatableCodableExistential.self,
        HashableDecodableExistential.self,
        HashableEncodableExistential.self,
        HashableCodableExistential.self,
    ]
}
