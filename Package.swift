// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "FluentRepository",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "FluentRepository",
            targets: ["FluentRepository"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.101.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.11.0")
    ],
    targets: [
        .target(
            name: "FluentRepository",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent")
            ],
            swiftSettings: .packageSettings
        )
    ]
)

extension Array where Element == SwiftSetting {
    static var packageSettings: [SwiftSetting] {
        [
            // Upcoming Features
            .enableUpcomingFeature("BareSlashRegexLiterals"),
            .enableUpcomingFeature("ConciseMagicFile"),
            .enableUpcomingFeature("DisableOutwardActorInference"),
            .enableUpcomingFeature("ForwardTrailingClosures"),
            .enableUpcomingFeature("GlobalConcurrency"),
            .enableUpcomingFeature("IsolatedDefaultValues"),

            // Experimental Features
            .enableExperimentalFeature("StrictConcurrency")
        ]
    }
}
