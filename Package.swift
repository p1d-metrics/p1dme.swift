// swift-tools-version:5.7
//
//  Package.swift
//

import PackageDescription

let package = Package(
    name: "P1d.metrics",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v4),
    ],
    products: [
        .library(
            name: "P1dme",
            targets: ["P1dme"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "P1dme"
        ),
        .testTarget(
            name: "P1dmeTests",
            dependencies: ["P1dme"],
            resources: [.process("Resources")]
        ),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
