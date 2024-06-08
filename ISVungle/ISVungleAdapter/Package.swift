
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISVungleAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISVungleAdapter", targets: ["ISVungleAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISVungleAdapter",
            path: "./ISVungleAdapter.xcframework"
        ),

    ]
)
