// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "GildedRose",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "GildedRose",
            targets: ["GildedRose"]
        ),
    ],
    targets: [
        .target(
            name: "GildedRose",
            dependencies: []
        ),
        .executableTarget(
            name: "GildedRoseApp",
            dependencies: ["GildedRose"]
        ),
        .testTarget(
            name: "GildedRoseTests",
            dependencies: ["GildedRose"]
        ),
    ]
)
