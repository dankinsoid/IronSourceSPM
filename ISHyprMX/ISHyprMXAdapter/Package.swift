
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISHyprMXAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISHyprMXAdapter", targets: ["ISHyprMXAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISHyprMXAdapter",
            path: "./ISHyprMXAdapter.xcframework"
        ),

    ]
)
