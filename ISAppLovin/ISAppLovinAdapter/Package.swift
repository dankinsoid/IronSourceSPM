
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISAppLovinAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISAppLovinAdapter", targets: ["ISAppLovinAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISAppLovinAdapter",
            path: "./ISAppLovinAdapter.xcframework"
        ),

    ]
)
