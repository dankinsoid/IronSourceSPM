
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISYandexAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISYandexAdapter", targets: ["ISYandexAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISYandexAdapter",
            path: "./ISYandexAdapter.xcframework"
        ),

    ]
)
