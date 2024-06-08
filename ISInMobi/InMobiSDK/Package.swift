
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "InMobiSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "InMobiSDK", targets: ["InMobiSDK"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "InMobiSDK",
            path: "./InMobiSDK.xcframework"
        ),

    ]
)
