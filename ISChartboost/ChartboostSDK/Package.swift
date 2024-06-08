
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ChartboostSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ChartboostSDK", targets: ["ChartboostSDK"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ChartboostSDK",
            path: "./ChartboostSDK.xcframework"
        ),

    ]
)
