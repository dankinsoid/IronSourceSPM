
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISAdMobAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISAdMobAdapter", targets: ["ISAdMobAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISAdMobAdapter",
            path: "./ISAdMobAdapter.xcframework"
        ),

    ]
)
