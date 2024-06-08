
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "MintegralSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "MintegralSDK", targets: ["MTGSDKInterstitialVideo","MTGSDKBanner","MTGSDKBidding","MTGSDKReward","MTGSDKNativeAdvanced","MTGSDKSplash","MTGSDKNewInterstitial","MTGSDK"]),
    ],
    targets: [
        
                .binaryTarget(
            name: "MTGSDKInterstitialVideo",
            path: "./MTGSDKInterstitialVideo.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDKBanner",
            path: "./MTGSDKBanner.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDKBidding",
            path: "./MTGSDKBidding.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDKReward",
            path: "./MTGSDKReward.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDKNativeAdvanced",
            path: "./MTGSDKNativeAdvanced.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDKSplash",
            path: "./MTGSDKSplash.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDKNewInterstitial",
            path: "./MTGSDKNewInterstitial.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDK",
            path: "./MTGSDK.xcframework"
        ),

    ]
)
