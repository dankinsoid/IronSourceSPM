
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "MolocoSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "MolocoSDK", targets: ["MolocoSDK"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "MolocoSDK",
            path: "./MolocoSDK.xcframework"
        ),

    ]
)
