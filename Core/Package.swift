// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension Array where Element == SwiftSetting {
    static let `default`: Self = [
        .unsafeFlags(["-Xfrontend", "-warn-long-function-bodies=100", "-Xfrontend", "-warn-long-expression-type-checking=100"], .when(configuration: .debug)),
        // For Swift 6
        .enableUpcomingFeature("ConciseMagicFile"),
        .enableUpcomingFeature("DisableOutwardActorInference"),
        .enableUpcomingFeature("ForwardTrailingClosures"),
        .enableUpcomingFeature("ImplicitOpenExistentials"),
        .enableUpcomingFeature("ImportObjcForwardDeclarations"),
        // For Swift 7
        .enableUpcomingFeature("ExistentialAny"),
    ]
}

let package = Package(
    name: "Core",
    defaultLocalization: "ja",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Clients",
            targets: ["Clients"]
        ),
        .library(
            name: "Features",
            targets: ["Features"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.9.1"),
        .package(url: "https://github.com/cybozu/LicenseList.git",
                 from: "0.7.0"),
    ],
    targets: [
        .target(
            name: "Clients",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            swiftSettings: .default
        ),
        .target(
            name: "Features",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            swiftSettings: .default
        ),
        .testTarget(
            name: "ClientTests",
            dependencies: ["Clients"]
        ),
        .testTarget(
            name: "FeatureTests",
            dependencies: ["Features"]
        ),
    ]
)
