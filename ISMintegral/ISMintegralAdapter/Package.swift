
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISMintegralAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISMintegralAdapter", targets: ["ISMintegralAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISMintegralAdapter",
            path: "./ISMintegralAdapter.xcframework"
        ),

    ]
)
