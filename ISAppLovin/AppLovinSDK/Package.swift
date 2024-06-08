
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "AppLovinSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "AppLovinSDK", targets: ["AppLovinSDK"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "AppLovinSDK",
            path: "./AppLovinSDK.xcframework"
        ),

    ]
)
