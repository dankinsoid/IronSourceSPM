
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISFacebookAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISFacebookAdapter", targets: ["ISFacebookAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISFacebookAdapter",
            path: "./ISFacebookAdapter.xcframework"
        ),

    ]
)
