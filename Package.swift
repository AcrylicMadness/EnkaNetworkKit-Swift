// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EnkaNetworkKit",
    platforms: [
        .iOS(.v15),
        .macCatalyst(.v15),
        .macOS(.v13),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "EnkaNetworkKit",
            targets: ["EnkaNetworkKit"]),
    ],
    dependencies: [
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "EnkaNetworkKit",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "EnkaNetworkKitTests",
            dependencies: ["EnkaNetworkKit"],
            path: "Tests"),
    ]
)
