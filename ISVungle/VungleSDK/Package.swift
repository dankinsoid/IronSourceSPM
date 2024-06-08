
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "VungleSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "VungleSDK", targets: ["VungleAdsSDK"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "VungleAdsSDK",
            path: "./dynamic/VungleAdsSDK.xcframework"
        ),

    ]
)
