// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "swift-conformable-existential",
    platforms: [.macOS(.v13), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftConformableExistential",
            targets: ["SwiftConformableExistential"]
        ),
        .executable(
            name: "SwiftConformableExistentialClient",
            targets: ["SwiftConformableExistentialClient"]
        ),
    ],
    dependencies: [
        // Depend on the Swift 5.9 release of SwiftSyntax
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
        .package(url: "https://github.com/stansmida/swift-extras.git", from: "0.7.4"),
        .package(url: "https://github.com/stansmida/swift-syntax-extras.git", from: "0.4.1"),
    ],
    targets: [

        // Library that exposes a macro as part of its API, which is used in client programs.
        .target(
            name: "SwiftConformableExistential",
            dependencies: [
                "SwiftConformableExistentialMacros",
                .product(name: "SwiftExtras", package: "swift-extras"),
                .product(name: "SwiftSyntaxExtras", package: "swift-syntax-extras"),
            ],
            swiftSettings: [.enableExperimentalFeature("AccessLevelOnImport")]
        ),

        // Macro implementation that performs the source transformation of a macro.
        .macro(
            name: "SwiftConformableExistentialMacros",
            dependencies: [
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "SwiftSyntaxExtras", package: "swift-syntax-extras"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
            ]
        ),

        // A client of the library, which is able to use the macro in its own code.
        .executableTarget(name: "SwiftConformableExistentialClient", dependencies: ["SwiftConformableExistential"]),

        .testTarget(
            name: "SwiftConformableExistentialMacrosTests",
            dependencies: [
                "SwiftConformableExistentialMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),

        .testTarget(
            name: "SwiftConformableExistentialTests",
            dependencies: [
                "SwiftConformableExistential",
            ]
        ),
    ]
)
