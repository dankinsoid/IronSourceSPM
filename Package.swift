// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IronSource",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(name: "IronSource", targets: ["IronSource", "IronSourceAdQualitySDK"]),
    ],
    dependencies: [
    ],
     targets: [
        .binaryTarget(
            name: "IronSource",
            url: "https://github.com/ironsource-mobile/iOS-sdk/raw/master/8.1.0/IronSource8.1.0.zip",
            checksum: "2af1acc57245a9e253f6fa61981cc3b48882c7767b9951e4fb70c4580ad509c9"
        ),
        .binaryTarget(
            name: "IronSourceAdQualitySDK",
            url: "https://github.com/ironsource-mobile/iOS-adqualitysdk/releases/download/IronSource_AdQuality_7.14.2/IronSourceAdQualitySDK-ios-v7.14.2.zip",
            checksum: "05f6f206148fd84c3bded71ef27c22448fedf555555c69cfcefccf9cf8a4fd0b"
        )
    ]
)
