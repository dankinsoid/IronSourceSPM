
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISInMobiAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISInMobiAdapter", targets: ["ISInMobiAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISInMobiAdapter",
            path: "./ISInMobiAdapter.xcframework"
        ),

    ]
)
