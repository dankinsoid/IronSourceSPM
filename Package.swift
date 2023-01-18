// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IronSource",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(name: "IronSource", targets: ["IronSource"]),
    ],
    dependencies: [
    ],
     targets: [
        .binaryTarget(
            name: "IronSource",
            url: "https://github.com/ironsource-mobile/iOS-sdk/raw/master/7.2.6/IronSource7.2.6.zip",
            checksum: "a028a1b2db6293c7b5715156dc3ebede5a1f79c49dd119f6d8bd25a2cc1a9cf4"
        )
    ]
)
