
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "MaioSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "MaioSDK", targets: ["Maio"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "Maio",
            path: "./Maio.xcframework"
        ),

    ]
)
