
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "HyprMXSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "HyprMXSDK", targets: ["HyprMX"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "HyprMX",
            path: "./HyprMX.xcframework"
        ),

    ]
)
