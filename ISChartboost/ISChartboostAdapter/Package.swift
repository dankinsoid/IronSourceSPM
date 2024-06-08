
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISChartboostAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISChartboostAdapter", targets: ["ISChartboostAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISChartboostAdapter",
            path: "./ISChartboostAdapter.xcframework"
        ),

    ]
)
