
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISAPSAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISAPSAdapter", targets: ["ISAPSAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISAPSAdapter",
            path: "./ISAPSAdapter.xcframework"
        ),

    ]
)
