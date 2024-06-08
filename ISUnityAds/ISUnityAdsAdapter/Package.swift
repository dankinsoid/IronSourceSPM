
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISUnityAdsAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISUnityAdsAdapter", targets: ["ISUnityAdsAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISUnityAdsAdapter",
            path: "./ISUnityAdsAdapter.xcframework"
        ),

    ]
)
