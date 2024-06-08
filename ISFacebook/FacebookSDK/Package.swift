
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "FacebookSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "FacebookSDK", targets: ["FBAudienceNetwork"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "FBAudienceNetwork",
            path: "./Dynamic/FBAudienceNetwork.xcframework"
        ),

    ]
)
