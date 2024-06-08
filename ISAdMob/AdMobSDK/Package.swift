
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "AdMobSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "AdMobSDK", targets: ["UserMessagingPlatform","GoogleMobileAds"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "UserMessagingPlatform",
            path: "./UserMessagingPlatform.xcframework"
        ),
        .binaryTarget(
            name: "GoogleMobileAds",
            path: "./GoogleMobileAds.xcframework"
        ),

    ]
)
