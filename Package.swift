
// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "IronSource",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "MaioSDK", targets: ["MaioSDK"]),
        .library(name: "ISMaioAdapter", targets: ["ISMaioAdapter"]),
        .library(name: "AppLovinSDK", targets: ["AppLovinSDK"]),
        .library(name: "ISAppLovinAdapter", targets: ["ISAppLovinAdapter"]),
        .library(name: "ChartboostSDK", targets: ["ChartboostSDK"]),
        .library(name: "ISChartboostAdapter", targets: ["ISChartboostAdapter"]),
        .library(name: "ISYandexAdapter", targets: ["ISYandexAdapter"]),
        .library(name: "ISMyTargetAdapter", targets: ["ISMyTargetAdapter"]),
        .library(name: "MintegralSDK", targets: ["MintegralSDK"]),
        .library(name: "ISMintegralAdapter", targets: ["ISMintegralAdapter"]),
        .library(name: "ISHyprMXAdapter", targets: ["ISHyprMXAdapter"]),
        .library(name: "HyprMXSDK", targets: ["HyprMXSDK"]),
        .library(name: "UnityAdsSDK", targets: ["UnityAdsSDK"]),
        .library(name: "ISUnityAdsAdapter", targets: ["ISUnityAdsAdapter"]),
        .library(name: "SuperAwesomeSDK", targets: ["SuperAwesomeSDK"]),
        .library(name: "ISSuperAwesomeAdapter", targets: ["ISSuperAwesomeAdapter"]),
        .library(name: "ISAdMobAdapter", targets: ["ISAdMobAdapter"]),
        .library(name: "AdMobSDK", targets: ["AdMobSDK"]),
        .library(name: "ISAPSAdapter", targets: ["ISAPSAdapter"]),
        .library(name: "APSSDK", targets: ["APSSDK"]),
        .library(name: "VungleSDK", targets: ["VungleSDK"]),
        .library(name: "ISVungleAdapter", targets: ["ISVungleAdapter"]),
        .library(name: "ISInMobiAdapter", targets: ["ISInMobiAdapter"]),
        .library(name: "InMobiSDK", targets: ["InMobiSDK"]),
        .library(name: "BidMachineSDK", targets: ["BidMachineSDK"]),
        .library(name: "ISBidMachineAdapter", targets: ["ISBidMachineAdapter"]),
        .library(name: "FacebookSDK", targets: ["FacebookSDK"]),
        .library(name: "ISFacebookAdapter", targets: ["ISFacebookAdapter"]),
        .library(name: "ISFyberAdapter", targets: ["ISFyberAdapter"]),
        .library(name: "FyberSDK", targets: ["FyberSDK"]),
        .library(name: "ISMolocoAdapter", targets: ["ISMolocoAdapter"]),
        .library(name: "MolocoSDK", targets: ["MolocoSDK"]),
        .library(name: "IronSource", targets: ["IronSource", "IronSourceAdQualitySDK"]),
    ],

    dependencies: [
        .package(url: "https://github.com/yandexmobile/yandex-ads-sdk-ios.git", from: "7.0.0"),
        .package(url: "https://github.com/myTargetSDK/mytarget-ios-spm.git", from: "5.0.0"),
        .package(path: "./ISMaio/MaioSDK"),
        .package(path: "./ISMaio/ISMaioAdapter"),
        .package(path: "./ISAppLovin/AppLovinSDK"),
        .package(path: "./ISAppLovin/ISAppLovinAdapter"),
        .package(path: "./ISChartboost/ChartboostSDK"),
        .package(path: "./ISChartboost/ISChartboostAdapter"),
        .package(path: "./ISYandex/ISYandexAdapter"),
        .package(path: "./ISMyTarget/ISMyTargetAdapter"),
        .package(path: "./ISMintegral/MintegralSDK"),
        .package(path: "./ISMintegral/ISMintegralAdapter"),
        .package(path: "./ISHyprMX/ISHyprMXAdapter"),
        .package(path: "./ISHyprMX/HyprMXSDK"),
        .package(path: "./ISUnityAds/UnityAdsSDK"),
        .package(path: "./ISUnityAds/ISUnityAdsAdapter"),
        .package(path: "./ISSuperAwesome/SuperAwesomeSDK"),
        .package(path: "./ISSuperAwesome/ISSuperAwesomeAdapter"),
        .package(path: "./ISAdMob/ISAdMobAdapter"),
        .package(path: "./ISAdMob/AdMobSDK"),
        .package(path: "./ISAPS/ISAPSAdapter"),
        .package(path: "./ISAPS/APSSDK"),
        .package(path: "./ISVungle/VungleSDK"),
        .package(path: "./ISVungle/ISVungleAdapter"),
        .package(path: "./ISInMobi/ISInMobiAdapter"),
        .package(path: "./ISInMobi/InMobiSDK"),
        .package(path: "./ISBidMachine/BidMachineSDK"),
        .package(path: "./ISBidMachine/ISBidMachineAdapter"),
        .package(path: "./ISFacebook/FacebookSDK"),
        .package(path: "./ISFacebook/ISFacebookAdapter"),
        .package(path: "./ISFyber/ISFyberAdapter"),
        .package(path: "./ISFyber/FyberSDK"),
        .package(path: "./ISMoloco/ISMolocoAdapter"),
        .package(path: "./ISMoloco/MolocoSDK"),
    ],
    targets: [
        .target(
            name: "MaioSDK",
            dependencies: [
                "MaioSDK"
            ],
            path: "./ISMaio/MaioSDK"
        ),
        .target(
            name: "ISMaioAdapter",
            dependencies: [
                "ISMaioAdapter"
            ],
            path: "./ISMaio/ISMaioAdapter"
        ),
        .target(
            name: "AppLovinSDK",
            dependencies: [
                "AppLovinSDK"
            ],
            path: "./ISAppLovin/AppLovinSDK"
        ),
        .target(
            name: "ISAppLovinAdapter",
            dependencies: [
                "ISAppLovinAdapter"
            ],
            path: "./ISAppLovin/ISAppLovinAdapter"
        ),
        .target(
            name: "ChartboostSDK",
            dependencies: [
                "ChartboostSDK"
            ],
            path: "./ISChartboost/ChartboostSDK"
        ),
        .target(
            name: "ISChartboostAdapter",
            dependencies: [
                "ISChartboostAdapter"
            ],
            path: "./ISChartboost/ISChartboostAdapter"
        ),
        .target(
            name: "ISYandexAdapter",
            dependencies: [
                "ISYandexAdapter"
            ],
            path: "./ISYandex/ISYandexAdapter"
        ),
        .target(
            name: "ISMyTargetAdapter",
            dependencies: [
                "ISMyTargetAdapter"
            ],
            path: "./ISMyTarget/ISMyTargetAdapter"
        ),
        .target(
            name: "MintegralSDK",
            dependencies: [
                "MintegralSDK"
            ],
            path: "./ISMintegral/MintegralSDK"
        ),
        .target(
            name: "ISMintegralAdapter",
            dependencies: [
                "ISMintegralAdapter"
            ],
            path: "./ISMintegral/ISMintegralAdapter"
        ),
        .target(
            name: "ISHyprMXAdapter",
            dependencies: [
                "ISHyprMXAdapter"
            ],
            path: "./ISHyprMX/ISHyprMXAdapter"
        ),
        .target(
            name: "HyprMXSDK",
            dependencies: [
                "HyprMXSDK"
            ],
            path: "./ISHyprMX/HyprMXSDK"
        ),
        .target(
            name: "UnityAdsSDK",
            dependencies: [
                "UnityAdsSDK"
            ],
            path: "./ISUnityAds/UnityAdsSDK"
        ),
        .target(
            name: "ISUnityAdsAdapter",
            dependencies: [
                "ISUnityAdsAdapter"
            ],
            path: "./ISUnityAds/ISUnityAdsAdapter"
        ),
        .target(
            name: "SuperAwesomeSDK",
            dependencies: [
                "SuperAwesomeSDK"
            ],
            path: "./ISSuperAwesome/SuperAwesomeSDK"
        ),
        .target(
            name: "ISSuperAwesomeAdapter",
            dependencies: [
                "ISSuperAwesomeAdapter"
            ],
            path: "./ISSuperAwesome/ISSuperAwesomeAdapter"
        ),
        .target(
            name: "ISAdMobAdapter",
            dependencies: [
                "ISAdMobAdapter"
            ],
            path: "./ISAdMob/ISAdMobAdapter"
        ),
        .target(
            name: "AdMobSDK",
            dependencies: [
                "AdMobSDK"
            ],
            path: "./ISAdMob/AdMobSDK"
        ),
        .target(
            name: "ISAPSAdapter",
            dependencies: [
                "ISAPSAdapter"
            ],
            path: "./ISAPS/ISAPSAdapter"
        ),
        .target(
            name: "APSSDK",
            dependencies: [
                "APSSDK"
            ],
            path: "./ISAPS/APSSDK"
        ),
        .target(
            name: "VungleSDK",
            dependencies: [
                "VungleSDK"
            ],
            path: "./ISVungle/VungleSDK"
        ),
        .target(
            name: "ISVungleAdapter",
            dependencies: [
                "ISVungleAdapter"
            ],
            path: "./ISVungle/ISVungleAdapter"
        ),
        .target(
            name: "ISInMobiAdapter",
            dependencies: [
                "ISInMobiAdapter"
            ],
            path: "./ISInMobi/ISInMobiAdapter"
        ),
        .target(
            name: "InMobiSDK",
            dependencies: [
                "InMobiSDK"
            ],
            path: "./ISInMobi/InMobiSDK"
        ),
        .target(
            name: "BidMachineSDK",
            dependencies: [
                "BidMachineSDK"
            ],
            path: "./ISBidMachine/BidMachineSDK"
        ),
        .target(
            name: "ISBidMachineAdapter",
            dependencies: [
                "ISBidMachineAdapter"
            ],
            path: "./ISBidMachine/ISBidMachineAdapter"
        ),
        .target(
            name: "FacebookSDK",
            dependencies: [
                "FacebookSDK"
            ],
            path: "./ISFacebook/FacebookSDK"
        ),
        .target(
            name: "ISFacebookAdapter",
            dependencies: [
                "ISFacebookAdapter"
            ],
            path: "./ISFacebook/ISFacebookAdapter"
        ),
        .target(
            name: "ISFyberAdapter",
            dependencies: [
                "ISFyberAdapter"
            ],
            path: "./ISFyber/ISFyberAdapter"
        ),
        .target(
            name: "FyberSDK",
            dependencies: [
                "FyberSDK"
            ],
            path: "./ISFyber/FyberSDK"
        ),
        .target(
            name: "ISMolocoAdapter",
            dependencies: [
                "ISMolocoAdapter"
            ],
            path: "./ISMoloco/ISMolocoAdapter"
        ),
        .target(
            name: "MolocoSDK",
            dependencies: [
                "MolocoSDK"
            ],
            path: "./ISMoloco/MolocoSDK"
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

