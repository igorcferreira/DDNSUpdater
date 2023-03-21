// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DDNSUpdater",
    platforms: [
        .iOS(.v13),
        .macOS(.v12),
        .tvOS(.v13),
        .macCatalyst(.v13),
        .watchOS(.v8)
    ],
    products: [
        .library(name: "DDNSUpdater", targets: ["DDNSUpdater"]),
        .executable(name: "updateddns", targets: ["updateddns"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "updateddns",
            dependencies: [
                .target(name: "DDNSUpdater"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .target(
           name: "DDNSUpdater",
           dependencies: []),
        .testTarget(
            name: "DDNSUpdaterTests",
            dependencies: ["DDNSUpdater"])
    ]
)
