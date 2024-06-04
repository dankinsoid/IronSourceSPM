
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "IronSource",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "ISMaio", targets: ["ISMaio"]),
        .library(name: "ISChartboost", targets: ["ISChartboost"]),
        .library(name: "ISYandex", targets: ["ISYandex"]),
        .library(name: "ISMintegral", targets: ["ISMintegral"]),
        .library(name: "ISHyprMX", targets: ["ISHyprMX"]),
        .library(name: "ISUnityAds", targets: ["ISUnityAds"]),
        .library(name: "ISSuperAwesome", targets: ["ISSuperAwesome"]),
        .library(name: "ISAdMob", targets: ["ISAdMob"]),
        .library(name: "ISAPS", targets: ["ISAPS"]),
        .library(name: "ISSmaato", targets: ["ISSmaato"]),
        .library(name: "ISVungle", targets: ["ISVungle"]),
        .library(name: "ISInMobi", targets: ["ISInMobi"]),
        .library(name: "ISBidMachine", targets: ["ISBidMachine"]),
        .library(name: "ISFacebook", targets: ["ISFacebook"]),
        .library(name: "ISFyber", targets: ["ISFyber"]),
        .library(name: "ISPangle", targets: ["ISPangle"]),
        .library(name: "ISMoloco", targets: ["ISMoloco"]),
        .library(name: "IronSource", targets: ["IronSource", "IronSourceAdQualitySDK"]),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "Maio",
            path: "./ISMaio/MaioSDK/Maio.xcframework"
        ),
        .binaryTarget(
            name: "ISMaioAdapter",
            path: "./ISMaio/ISMaioAdapter/ISMaioAdapter.xcframework"
        ),
        .target(
            name: "ISMaio",
            dependencies: [
                "Maio","ISMaioAdapter"
            ],
            path: "./ISMaio",
            resources: []
        ),
        .binaryTarget(
            name: "ChartboostSDK",
            path: "./ISChartboost/ChartboostSDK/ChartboostSDK.xcframework"
        ),
        .binaryTarget(
            name: "ISChartboostAdapter",
            path: "./ISChartboost/ISChartboostAdapter/ISChartboostAdapter.xcframework"
        ),
        .target(
            name: "ISChartboost",
            dependencies: [
                "ChartboostSDK","ISChartboostAdapter"
            ],
            path: "./ISChartboost",
            resources: []
        ),
        .binaryTarget(
            name: "YandexMobileAds",
            path: "./ISYandex/YandexSDK/static/YandexMobileAds.xcframework"
        ),
        .binaryTarget(
            name: "ISYandexAdapter",
            path: "./ISYandex/ISYandexAdapter/ISYandexAdapter.xcframework"
        ),
        .target(
            name: "ISYandex",
            dependencies: [
                "YandexMobileAds","ISYandexAdapter"
            ],
            path: "./ISYandex",
            resources: [.copy("YandexSDK/PrivacyInfo.xcprivacy")]
        ),
        .binaryTarget(
            name: "MTGSDKInterstitialVideo",
            path: "./ISMintegral/MintegralSDK/MTGSDKInterstitialVideo.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDKBanner",
            path: "./ISMintegral/MintegralSDK/MTGSDKBanner.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDKBidding",
            path: "./ISMintegral/MintegralSDK/MTGSDKBidding.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDKReward",
            path: "./ISMintegral/MintegralSDK/MTGSDKReward.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDKNativeAdvanced",
            path: "./ISMintegral/MintegralSDK/MTGSDKNativeAdvanced.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDKSplash",
            path: "./ISMintegral/MintegralSDK/MTGSDKSplash.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDKNewInterstitial",
            path: "./ISMintegral/MintegralSDK/MTGSDKNewInterstitial.xcframework"
        ),
        .binaryTarget(
            name: "MTGSDK",
            path: "./ISMintegral/MintegralSDK/MTGSDK.xcframework"
        ),
        .binaryTarget(
            name: "ISMintegralAdapter",
            path: "./ISMintegral/ISMintegralAdapter/ISMintegralAdapter.xcframework"
        ),
        .target(
            name: "ISMintegral",
            dependencies: [
                "MTGSDKInterstitialVideo","MTGSDKBanner","MTGSDKBidding","MTGSDKReward","MTGSDKNativeAdvanced","MTGSDKSplash","MTGSDKNewInterstitial","MTGSDK","ISMintegralAdapter"
            ],
            path: "./ISMintegral",
            resources: []
        ),
        .binaryTarget(
            name: "ISHyprMXAdapter",
            path: "./ISHyprMX/ISHyprMXAdapter/ISHyprMXAdapter.xcframework"
        ),
        .binaryTarget(
            name: "HyprMX",
            path: "./ISHyprMX/HyprMXSDK/HyprMX.xcframework"
        ),
        .target(
            name: "ISHyprMX",
            dependencies: [
                "ISHyprMXAdapter","HyprMX"
            ],
            path: "./ISHyprMX",
            resources: []
        ),
        .binaryTarget(
            name: "UnityAds",
            path: "./ISUnityAds/UnityAdsSDK/UnityAds.xcframework"
        ),
        .binaryTarget(
            name: "ISUnityAdsAdapter",
            path: "./ISUnityAds/ISUnityAdsAdapter/ISUnityAdsAdapter.xcframework"
        ),
        .target(
            name: "ISUnityAds",
            dependencies: [
                "UnityAds","ISUnityAdsAdapter"
            ],
            path: "./ISUnityAds",
            resources: []
        ),
        .binaryTarget(
            name: "ISSuperAwesomeAdapter",
            path: "./ISSuperAwesome/ISSuperAwesomeAdapter/ISSuperAwesomeAdapter.xcframework"
        ),
        .target(
            name: "ISSuperAwesome",
            dependencies: [
                "ISSuperAwesomeAdapter"
            ],
            path: "./ISSuperAwesome",
            resources: [.copy("SuperAwesomeSDK/PrivacyInfo.xcprivacy")]
        ),
        .binaryTarget(
            name: "ISAdMobAdapter",
            path: "./ISAdMob/ISAdMobAdapter/ISAdMobAdapter.xcframework"
        ),
        .binaryTarget(
            name: "UserMessagingPlatform",
            path: "./ISAdMob/AdMobSDK/UserMessagingPlatform.xcframework"
        ),
        .binaryTarget(
            name: "GoogleMobileAds",
            path: "./ISAdMob/AdMobSDK/GoogleMobileAds.xcframework"
        ),
        .target(
            name: "ISAdMob",
            dependencies: [
                "ISAdMobAdapter","UserMessagingPlatform","GoogleMobileAds"
            ],
            path: "./ISAdMob",
            resources: []
        ),
        .binaryTarget(
            name: "ISAPSAdapter",
            path: "./ISAPS/ISAPSAdapter/ISAPSAdapter.xcframework"
        ),
        .binaryTarget(
            name: "APSAdMobAdapter",
            path: "./ISAPS/APSSDK/APSAdMobAdapter.xcframework"
        ),
        .binaryTarget(
            name: "DTBiOSSDK",
            path: "./ISAPS/APSSDK/DTBiOSSDK.xcframework"
        ),
        .target(
            name: "ISAPS",
            dependencies: [
                "ISAPSAdapter","APSAdMobAdapter","DTBiOSSDK"
            ],
            path: "./ISAPS",
            resources: []
        ),
        .binaryTarget(
            name: "ISSmaatoAdapter",
            path: "./ISSmaato/ISSmaatoAdapter/ISSmaatoAdapter.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKRewardedAds",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKRewardedAds.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKInterstitial",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKInterstitial.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKFacebookCSMBannerAdapter",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKFacebookCSMBannerAdapter.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKFacebookCSMRewardedVideoAdapter",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKFacebookCSMRewardedVideoAdapter.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKAdMobCSMInterstitialAdapter",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKAdMobCSMInterstitialAdapter.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKCore",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKCore.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKNative",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKNative.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKCMP",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKCMP.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKUnifiedBidding",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKUnifiedBidding.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKRichMedia",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKRichMedia.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKVideo",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKVideo.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKOpenMeasurement",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKOpenMeasurement.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKAdMobCSMRewardedVideoAdapter",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKAdMobCSMRewardedVideoAdapter.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKInAppBidding",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKInAppBidding.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKBanner",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKBanner.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKFacebookCSMInterstitialAdapter",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKFacebookCSMInterstitialAdapter.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKAdMobCSMBannerAdapter",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKAdMobCSMBannerAdapter.xcframework"
        ),
        .binaryTarget(
            name: "SmaatoSDKOutstream",
            path: "./ISSmaato/SmaatoSDK/SmaatoSDKOutstream.xcframework"
        ),
        .binaryTarget(
            name: "OMSDK_Smaato",
            path: "./ISSmaato/SmaatoSDK/vendor/OMSDK_Smaato.xcframework"
        ),
        .target(
            name: "ISSmaato",
            dependencies: [
                "ISSmaatoAdapter","SmaatoSDKRewardedAds","SmaatoSDKInterstitial","SmaatoSDKFacebookCSMBannerAdapter","SmaatoSDKFacebookCSMRewardedVideoAdapter","SmaatoSDKAdMobCSMInterstitialAdapter","SmaatoSDKCore","SmaatoSDKNative","SmaatoSDKCMP","SmaatoSDKUnifiedBidding","SmaatoSDKRichMedia","SmaatoSDKVideo","SmaatoSDKOpenMeasurement","SmaatoSDKAdMobCSMRewardedVideoAdapter","SmaatoSDKInAppBidding","SmaatoSDKBanner","SmaatoSDKFacebookCSMInterstitialAdapter","SmaatoSDKAdMobCSMBannerAdapter","SmaatoSDKOutstream","OMSDK_Smaato"
            ],
            path: "./ISSmaato",
            resources: [.copy("SmaatoSDK/PrivacyInfo.xcprivacy")]
        ),
        .binaryTarget(
            name: "VungleAdsSDK",
            path: "./ISVungle/VungleSDK/dynamic/VungleAdsSDK.xcframework"
        ),
        .binaryTarget(
            name: "ISVungleAdapter",
            path: "./ISVungle/ISVungleAdapter/ISVungleAdapter.xcframework"
        ),
        .target(
            name: "ISVungle",
            dependencies: [
                "VungleAdsSDK","ISVungleAdapter"
            ],
            path: "./ISVungle",
            resources: []
        ),
        .binaryTarget(
            name: "ISInMobiAdapter",
            path: "./ISInMobi/ISInMobiAdapter/ISInMobiAdapter.xcframework"
        ),
        .binaryTarget(
            name: "InMobiSDK",
            path: "./ISInMobi/InMobiSDK/InMobiSDK.xcframework"
        ),
        .target(
            name: "ISInMobi",
            dependencies: [
                "ISInMobiAdapter","InMobiSDK"
            ],
            path: "./ISInMobi",
            resources: []
        ),
        .binaryTarget(
            name: "BidMachine",
            path: "./ISBidMachine/BidMachineSDK/BidMachine.xcframework"
        ),
        .binaryTarget(
            name: "ISBidMachineAdapter",
            path: "./ISBidMachine/ISBidMachineAdapter/ISBidMachineAdapter.xcframework"
        ),
        .target(
            name: "ISBidMachine",
            dependencies: [
                "BidMachine","ISBidMachineAdapter"
            ],
            path: "./ISBidMachine",
            resources: []
        ),
        .binaryTarget(
            name: "FBAudienceNetwork",
            path: "./ISFacebook/FacebookSDK/Dynamic/FBAudienceNetwork.xcframework"
        ),
        .binaryTarget(
            name: "ISFacebookAdapter",
            path: "./ISFacebook/ISFacebookAdapter/ISFacebookAdapter.xcframework"
        ),
        .target(
            name: "ISFacebook",
            dependencies: [
                "FBAudienceNetwork","ISFacebookAdapter"
            ],
            path: "./ISFacebook",
            resources: []
        ),
        .binaryTarget(
            name: "ISFyberAdapter",
            path: "./ISFyber/ISFyberAdapter/ISFyberAdapter.xcframework"
        ),
        .binaryTarget(
            name: "IASDKCore",
            path: "./ISFyber/FyberSDK/IASDKCore/IASDKCore.xcframework"
        ),
        .target(
            name: "ISFyber",
            dependencies: [
                "ISFyberAdapter","IASDKCore"
            ],
            path: "./ISFyber",
            resources: [.copy("FyberSDK/DTExchangeTestAppPUB/PrivacyInfo.xcprivacy")]
        ),
        .binaryTarget(
            name: "BURelyFoundation_Global",
            path: "./ISPangle/PangleSDK/SDK/BURelyFoundation_Global.xcframework"
        ),
        .binaryTarget(
            name: "PAGAdSDK",
            path: "./ISPangle/PangleSDK/SDK/PAGAdSDK.xcframework"
        ),
        .binaryTarget(
            name: "BURelyAdSDK",
            path: "./ISPangle/PangleSDK/SDK/BURelyAdSDK.xcframework"
        ),
        .binaryTarget(
            name: "ISPangleAdapter",
            path: "./ISPangle/ISPangleAdapter/ISPangleAdapter.xcframework"
        ),
        .target(
            name: "ISPangle",
            dependencies: [
                "BURelyFoundation_Global","PAGAdSDK","BURelyAdSDK","ISPangleAdapter"
            ],
            path: "./ISPangle",
            resources: [.copy("PangleSDK/SDK/PAGAdSDK.bundle/PrivacyInfo.xcprivacy")]
        ),
        .binaryTarget(
            name: "ISMolocoAdapter",
            path: "./ISMoloco/ISMolocoAdapter/ISMolocoAdapter.xcframework"
        ),
        .binaryTarget(
            name: "MolocoSDK",
            path: "./ISMoloco/MolocoSDK/MolocoSDK.xcframework"
        ),
        .target(
            name: "ISMoloco",
            dependencies: [
                "ISMolocoAdapter","MolocoSDK"
            ],
            path: "./ISMoloco",
            resources: []
        ),
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

