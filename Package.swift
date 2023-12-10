// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "ConformableExistential",
    platforms: [.macOS(.v13), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ConformableExistential",
            targets: ["ConformableExistential"]
        ),
        .executable(
            name: "ConformableExistentialClient",
            targets: ["ConformableExistentialClient"]
        ),
    ],
    dependencies: [
        // Depend on the Swift 5.9 release of SwiftSyntax
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
        .package(url: "https://github.com/stansmida/swift-extras.git", exact: "0.6.0"),
        .package(url: "https://github.com/stansmida/swift-syntax-extras.git", exact: "0.4.1"),
    ],
    targets: [
        // Macro implementation that performs the source transformation of a macro.
        .macro(
            name: "ConformableExistentialMacros",
            dependencies: [
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "SwiftSyntaxExtras", package: "swift-syntax-extras"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
            ]
        ),

        // Library that exposes a macro as part of its API, which is used in client programs.
        .target(
            name: "ConformableExistential",
            dependencies: [
                "ConformableExistentialMacros",
                .product(name: "SwiftExtras", package: "swift-extras"),
            ],
            swiftSettings: [.enableExperimentalFeature("AccessLevelOnImport")]
        ),

        // A client of the library, which is able to use the macro in its own code.
        .executableTarget(name: "ConformableExistentialClient", dependencies: ["ConformableExistential"]),

        .testTarget(
            name: "ConformableExistentialMacrosTests",
            dependencies: [
                "ConformableExistentialMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),

        .testTarget(
            name: "ConformableExistentialTests",
            dependencies: [
                "ConformableExistential",
            ]
        ),
    ]
)
