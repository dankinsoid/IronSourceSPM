
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "UnityAdsSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "UnityAdsSDK", targets: ["UnityAds"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "UnityAds",
            path: "./UnityAds.xcframework"
        ),

    ]
)
