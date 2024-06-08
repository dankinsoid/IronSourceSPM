
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "ISMolocoAdapter",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISMolocoAdapter", targets: ["ISMolocoAdapter"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "ISMolocoAdapter",
            path: "./ISMolocoAdapter.xcframework"
        ),

    ]
)
