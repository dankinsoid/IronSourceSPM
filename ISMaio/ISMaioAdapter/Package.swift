
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISMaioAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISMaioAdapter", targets: ["ISMaioAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISMaioAdapter",
            path: "./ISMaioAdapter.xcframework"
        ),

    ]
)
