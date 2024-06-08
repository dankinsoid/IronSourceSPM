
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "SuperAwesomeSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "SuperAwesomeSDK", targets: ["SuperAwesomeSDKResources"]),
    ],
    targets: [
        .target(
            name: "SuperAwesomeSDKResources",
            dependencies: [
                
            ],
            path: "./",
            resources: [
                .copy("PrivacyInfo.xcprivacy"),
            ]
        ),
        
    ]
)
