
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "APSSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "APSSDK", targets: ["APSAdMobAdapter","DTBiOSSDK"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "APSAdMobAdapter",
            path: "./APSAdMobAdapter.xcframework"
        ),
        .binaryTarget(
            name: "DTBiOSSDK",
            path: "./DTBiOSSDK.xcframework"
        ),

    ]
)
