
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "FyberSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "FyberSDK", targets: ["FyberSDKResources"]),
    ],
    targets: [
        .target(
            name: "FyberSDKResources",
            dependencies: [
                "IASDKCore"
            ],
            path: "./",
            resources: [
                .copy("DTExchangeTestAppPUB/PrivacyInfo.xcprivacy"),
            ]
        ),
                .binaryTarget(
            name: "IASDKCore",
            path: "./IASDKCore/IASDKCore.xcframework"
        ),

    ]
)
