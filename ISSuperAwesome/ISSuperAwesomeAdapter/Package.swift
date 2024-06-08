
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISSuperAwesomeAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISSuperAwesomeAdapter", targets: ["ISSuperAwesomeAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISSuperAwesomeAdapter",
            path: "./ISSuperAwesomeAdapter.xcframework"
        ),

    ]
)
