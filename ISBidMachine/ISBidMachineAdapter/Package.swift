
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISBidMachineAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISBidMachineAdapter", targets: ["ISBidMachineAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISBidMachineAdapter",
            path: "./ISBidMachineAdapter.xcframework"
        ),

    ]
)
