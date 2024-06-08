
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "BidMachineSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "BidMachineSDK", targets: ["BidMachine"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "BidMachine",
            path: "./BidMachine.xcframework"
        ),

    ]
)
