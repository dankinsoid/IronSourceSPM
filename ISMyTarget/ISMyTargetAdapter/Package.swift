
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISMyTargetAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISMyTargetAdapter", targets: ["ISMyTargetAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISMyTargetAdapter",
            path: "./ISMyTargetAdapter.xcframework"
        ),

    ]
)
