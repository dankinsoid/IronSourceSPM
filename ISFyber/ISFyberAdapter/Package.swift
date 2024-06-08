
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISFyberAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISFyberAdapter", targets: ["ISFyberAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISFyberAdapter",
            path: "./ISFyberAdapter.xcframework"
        ),

    ]
)
