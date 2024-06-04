//
//  SmaatoApplovinMediationAdapter.m
//  SmaatoSDKApplovinWaterfallAdapter
//
//  Created by Ashwinee Mhaske on 05/10/23.
//  Copyright © 2023 Smaato. All rights reserved.
//

#import "SmaatoApplovinMediationAdapter.h"
#import <SmaatoSDKCore/SmaatoSDKCore.h>
#import <SmaatoSDKBanner/SmaatoSDKBanner.h>
#import <SmaatoSDKInterstitial/SmaatoSDKInterstitial.h>
#import <SmaatoSDKRewardedAds/SmaatoSDKRewardedAds.h>

static NSString *const kSmaatoApplovinMediationAdaptorVersion = @"11.11.3.0";

/**
 * Smaato banners are instance-based.
 */
@interface SmaatoApplovinMediationBannerAdDelegate : NSObject <SMABannerViewDelegate>
@property (nonatomic, weak) SmaatoApplovinMediationAdapter *smaatoWaterfallAdapter;
@property (nonatomic, strong) id<MAAdViewAdapterDelegate> delegate;
- (instancetype)initWithSmaatoWaterfallAdapter:(SmaatoApplovinMediationAdapter *)smaatoWaterfallAdapter andNotify:(id<MAAdViewAdapterDelegate>)delegate;
@end

@interface SmaatoAppLovinMediationInterstitialAdDelegate : NSObject<SMAInterstitialDelegate>
@property (nonatomic, weak) SmaatoApplovinMediationAdapter *smaatoWaterfallAdapter;
@property (nonatomic, strong) id<MAInterstitialAdapterDelegate> delegate;
- (instancetype)initWithSmaatoWaterfallAdapter:(SmaatoApplovinMediationAdapter *)smaatoWaterfallAdapter andNotify:(id<MAInterstitialAdapterDelegate>)delegate;
@end

@interface SmaatoAppLovinMediationRewardedAdDelegate : NSObject<SMARewardedInterstitialDelegate>
@property (nonatomic, weak) SmaatoApplovinMediationAdapter *smaatoWaterfallAdapter;
@property (nonatomic, strong) id<MARewardedAdapterDelegate> delegate;
@property (nonatomic, assign, getter=hasGrantedReward) BOOL grantedReward;
- (instancetype)initWithSmaatoWaterfallAdapter:(SmaatoApplovinMediationAdapter *)smaatoWaterfallAdapter andNotify:(id<MARewardedAdapterDelegate>)delegate;
@end

@interface SmaatoApplovinMediationAdapter()

// BannerAdView Properties

@property (nonatomic, strong) SMABannerView *bannerAdView;
@property (nonatomic, strong) SmaatoApplovinMediationBannerAdDelegate *bannerAdViewAdapterDelegate;

// Interstitial
@property (nonatomic, strong) SMAInterstitial *interstitialAd;
@property (nonatomic, strong) SmaatoAppLovinMediationInterstitialAdDelegate *interstitialAdapterDelegate;

// Rewarded
@property (nonatomic, strong) SMARewardedInterstitial *rewardedAd;
@property (nonatomic, strong) SmaatoAppLovinMediationRewardedAdDelegate *rewardedAdapterDelegate;


@end
@implementation SmaatoApplovinMediationAdapter


- (void)initializeWithParameters:(id<MAAdapterInitializationParameters>)parameters completionHandler:(void (^)(MAAdapterInitializationStatus, NSString *_Nullable))completionHandler {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *pubID = [parameters.serverParameters al_stringForKey: @"pub_id" defaultValue: @""];
        [self log: @"Initializing Smaato SDK with publisher id: %@...", pubID];
        
        [self updateAgeRestrictedUser: parameters];
        
        [self updateLocationCollectionEnabled: parameters];
        
        SMAConfiguration *config = [[SMAConfiguration alloc] initWithPublisherId: pubID];
        config.logLevel = [parameters isTesting] ? kSMALogLevelVerbose : kSMALogLevelError;
        config.httpsOnly = [parameters.serverParameters al_numberForKey: @"https_only"].boolValue;
        
        [SmaatoSDK initSDKWithConfig: config];
    });
    
    completionHandler(MAAdapterInitializationStatusInitializedSuccess,nil);
}

- (NSString *)SDKVersion
{
    return [SmaatoSDK sdkVersion];
}

- (NSString *)adapterVersion
{
    return kSmaatoApplovinMediationAdaptorVersion;
}


#pragma mark - Helper Methods

- (void)updateLocationCollectionEnabled:(id<MAAdapterParameters>)parameters
{
    if ( ALSdk.versionCode >= 11000000 )
    {
        NSDictionary<NSString *, id> *localExtraParameters = parameters.localExtraParameters;
        NSNumber *isLocationCollectionEnabled = [localExtraParameters al_numberForKey: @"is_location_collection_enabled"];
        if ( isLocationCollectionEnabled )
        {
            [self log: @"Setting location collection enabled: %@", isLocationCollectionEnabled];
            // NOTE: According to docs - this is disabled by default
            SmaatoSDK.gpsEnabled = isLocationCollectionEnabled.boolValue;
        }
    }
}

- (void)updateAgeRestrictedUser:(id<MAAdapterParameters>)parameters
{
    NSNumber *isAgeRestrictedUser = [parameters isAgeRestrictedUser];
    if ( isAgeRestrictedUser )
    {
        SmaatoSDK.requireCoppaCompliantAds = isAgeRestrictedUser.boolValue;
    }
}

- (SMABannerAdSize)adSizeForAdFormat:(MAAdFormat *)adFormat
{
    if ( adFormat == MAAdFormat.banner )
    {
        return kSMABannerAdSizeXXLarge_320x50;
    }
    else if ( adFormat == MAAdFormat.mrec )
    {
        return kSMABannerAdSizeMediumRectangle_300x250;
    }
    else if ( adFormat == MAAdFormat.leader )
    {
        return kSMABannerAdSizeLeaderboard_728x90;
    }
    else
    {
        [NSException raise: NSInvalidArgumentException format: @"Unsupported ad format: %@", adFormat];
        return kSMABannerAdSizeAny;
    }
}

+ (MAAdapterError *)toMaxError:(NSError *)smaatoError
{
    NSInteger smaatoErrorCode = smaatoError.code;
    MAAdapterError *adapterError = MAAdapterError.unspecified;
    switch ( smaatoErrorCode )
    {
        case 1:
        case 204:
            adapterError = MAAdapterError.noFill;
            break;
        case 100:
            adapterError = MAAdapterError.noConnection;
            break;
        case 203:
            adapterError = MAAdapterError.invalidConfiguration;
            break;
        default:
            adapterError = MAAdapterError.unspecified;
    }
    return [MAAdapterError errorWithCode:adapterError.errorCode errorString:adapterError.errorMessage mediatedNetworkErrorCode:smaatoErrorCode mediatedNetworkErrorMessage:smaatoError.localizedDescription];
}

- (void)destroy
{
    self.bannerAdView.delegate = nil;
    self.bannerAdView = nil;
    self.bannerAdViewAdapterDelegate.delegate = nil;
    self.bannerAdViewAdapterDelegate = nil;
    self.interstitialAdapterDelegate.delegate = nil;
    self.interstitialAd = nil;
    self.rewardedAdapterDelegate = nil;
    self.rewardedAd = nil;
}

#pragma mark - MAAdViewAdapter Methods

- (void)loadAdViewAdForParameters:(id<MAAdapterResponseParameters>)parameters adFormat:(MAAdFormat *)adFormat andNotify:(id<MAAdViewAdapterDelegate>)delegate
{
    [self log: @"Loading %@ ad view ad...", adFormat.label];
    
    NSString* placementIdentifier = [parameters thirdPartyAdPlacementIdentifier];
    [self updateAgeRestrictedUser: parameters];
    [self updateLocationCollectionEnabled: parameters];
    
    self.bannerAdView = [[SMABannerView alloc] init];
    self.bannerAdView.autoreloadInterval = kSMABannerAutoreloadIntervalDisabled;
    
    self.bannerAdViewAdapterDelegate = [[SmaatoApplovinMediationBannerAdDelegate alloc] initWithSmaatoWaterfallAdapter:self andNotify:delegate];
    self.bannerAdView.delegate = self.bannerAdViewAdapterDelegate;
    
    if ( !placementIdentifier || ![placementIdentifier al_isValidString] )
    {
        [self log: @"%@ ad load failed: ad request nil with valid bid response", adFormat.label];
        [delegate didFailToLoadAdViewAdWithError: MAAdapterError.invalidConfiguration];
    }
    else
    {
        [self.bannerAdView loadWithAdSpaceId: placementIdentifier adSize: [self adSizeForAdFormat: adFormat]];
    }
}
#pragma mark - MAInterstitialAdapter Methods

- (void)loadInterstitialAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MAInterstitialAdapterDelegate>)delegate
{
    NSString* placementIdentifier = parameters.thirdPartyAdPlacementIdentifier;
    [self updateAgeRestrictedUser: parameters];
    [self updateLocationCollectionEnabled: parameters];
    
    if ( !placementIdentifier || ![placementIdentifier al_isValidString])
    {
        [self log: @"Interstitial ad load failed: ad request nil with valid bid response"];
        [delegate didFailToLoadInterstitialAdWithError: MAAdapterError.invalidConfiguration];
    }
    else
    {
        [SmaatoSDK loadInterstitialForAdSpaceId: placementIdentifier delegate: self.interstitialAdapterDelegate];
    }
}

- (void)showInterstitialAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MAInterstitialAdapterDelegate>)delegate
{
    NSString *placementIdentifier = parameters.thirdPartyAdPlacementIdentifier;
    [self log: @"Showing interstitial ad for placement: %@...", placementIdentifier];
    
    
    if ( [self.interstitialAd availableForPresentation] )
    {
        UIViewController *presentingViewController;
        if ( ALSdk.versionCode >= 11020199 )
        {
            presentingViewController = parameters.presentingViewController ?: [ALUtils topViewControllerFromKeyWindow];
        }
        else
        {
            presentingViewController = [ALUtils topViewControllerFromKeyWindow];
        }
        
        [self.interstitialAd showFromViewController: presentingViewController];
    }
    else
    {
        [self log: @"Interstitial ad not ready"];
        [delegate didFailToDisplayInterstitialAdWithError:MAAdapterError.adNotReady];
    }
}
#pragma mark - MARewardedAdapter Methods

- (void)loadRewardedAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MARewardedAdapterDelegate>)delegate
{
    NSString* placementIdentifier = parameters.thirdPartyAdPlacementIdentifier;
    
    [self updateAgeRestrictedUser: parameters];
    [self updateLocationCollectionEnabled: parameters];
    
    
    if (!placementIdentifier || ![placementIdentifier al_isValidString])
    {
        [self log: @"Rewarded ad load failed: ad request nil with valid bid response"];
        [delegate didFailToLoadRewardedAdWithError: MAAdapterError.invalidConfiguration];
    }
    else
    {
        [SmaatoSDK loadRewardedInterstitialForAdSpaceId: placementIdentifier delegate: self.rewardedAdapterDelegate];
    }
}
- (void)showRewardedAdForParameters:(id<MAAdapterResponseParameters>)parameters andNotify:(id<MARewardedAdapterDelegate>)delegate
{
    NSString *placementIdentifier = parameters.thirdPartyAdPlacementIdentifier;
    [self log: @"Showing rewarded ad for placement: %@...", placementIdentifier];
    
    
    if ( [self.rewardedAd availableForPresentation] )
    {
        // Configure reward from server.
        [self configureRewardForParameters: parameters];
        
        UIViewController *presentingViewController;
        if ( ALSdk.versionCode >= 11020199 )
        {
            presentingViewController = parameters.presentingViewController ?: [ALUtils topViewControllerFromKeyWindow];
        }
        else
        {
            presentingViewController = [ALUtils topViewControllerFromKeyWindow];
        }
        
        [self.rewardedAd showFromViewController: presentingViewController];
    }
    else
    {
        [self log: @"Rewarded ad not ready"];
        [delegate didFailToDisplayRewardedAdWithError: MAAdapterError.adNotReady];
    }
}
@end

#pragma mark - Smaato BannerAdView Delegate

@implementation SmaatoApplovinMediationBannerAdDelegate

- (instancetype)initWithSmaatoWaterfallAdapter:(SmaatoApplovinMediationAdapter *)smaatoWaterfallAdapter andNotify:(id<MAAdViewAdapterDelegate>)delegate
{
    self = [super init];
    if ( self )
    {
        self.smaatoWaterfallAdapter = smaatoWaterfallAdapter;
        self.delegate = delegate;
    }
    return self;
}

- (UIViewController *)presentingViewControllerForBannerView:(SMABannerView *)bannerView
{
    return [ALUtils topViewControllerFromKeyWindow];
}

- (void)bannerViewDidLoad:(SMABannerView *)bannerView
{
    [self.smaatoWaterfallAdapter log: @"BannerAdView loaded"];
    
    // Passing extra info such as creative id supported in 6.15.0+
    if ( ALSdk.versionCode >= 6150000 && [bannerView.sci al_isValidString] )
    {
        [self.delegate performSelector: @selector(didLoadAdForAdView:withExtraInfo:)
                            withObject: bannerView
                            withObject: @{@"creative_id" : bannerView.sci}];
    }
    else
    {
        [self.delegate didLoadAdForAdView: bannerView];
    }
}

- (void)bannerView:(SMABannerView *)bannerView didFailWithError:(NSError *)error
{
    [self.smaatoWaterfallAdapter log: @"BannerAdView failed to load with error: %@", error];
    
    MAAdapterError *adapterError = [SmaatoApplovinMediationAdapter toMaxError: error];
    [self.delegate didFailToLoadAdViewAdWithError: adapterError];
}

- (void)bannerViewDidTTLExpire:(SMABannerView *)bannerView
{
    [self.smaatoWaterfallAdapter log: @"BannerAdView ad expired"];
}

- (void)bannerViewDidImpress:(SMABannerView *)bannerView
{
    [self.smaatoWaterfallAdapter log: @"BannerAdView displayed"];
    [self.delegate didDisplayAdViewAd];
}

- (void)bannerViewDidClick:(SMABannerView *)bannerView
{
    [self.smaatoWaterfallAdapter log: @"BannerAdView clicked"];
    [self.delegate didClickAdViewAd];
}

- (void)bannerViewDidPresentModalContent:(SMABannerView *)bannerView
{
    [self.smaatoWaterfallAdapter log: @"BannerAdView expanded"];
    [self.delegate didExpandAdViewAd];
}

- (void)bannerViewDidDismissModalContent:(SMABannerView *)bannerView
{
    [self.smaatoWaterfallAdapter log: @"BannerAdView collapsed"];
    [self.delegate didCollapseAdViewAd];
}
@end

#pragma mark - Interstitial Delegate Methods

@implementation SmaatoAppLovinMediationInterstitialAdDelegate

- (instancetype)initWithSmaatoWaterfallAdapter:(SmaatoApplovinMediationAdapter *)parentAdapter andNotify:(id<MAInterstitialAdapterDelegate>)delegate
{
    self = [super init];
    if ( self )
    {
        self.smaatoWaterfallAdapter = parentAdapter;
        self.delegate = delegate;
    }
    return self;
}

- (void)interstitialDidTrackImpression
{
    [self.smaatoWaterfallAdapter log: @"Interstitial did track impression"];
    [self.delegate didDisplayInterstitialAd];
}

- (void)interstitialDidTrackClick
{
    [self.smaatoWaterfallAdapter log: @"Interstitial clicked"];
    [self.delegate didClickInterstitialAd];
}

- (void)interstitialDidDismiss
{
    [self.smaatoWaterfallAdapter log: @"Interstitial hidden"];
    [self.delegate didHideInterstitialAd];
}

- (void)interstitialDidTTLExpire:(SMAInterstitial * _Nonnull)interstitial {
    [self.smaatoWaterfallAdapter log: @"Interstitial TTL Expire"];
}
- (void)interstitialDidLoad:(SMAInterstitial *)interstitial
{
    [self.smaatoWaterfallAdapter log: @"Interstitial ad loaded"];
    [self.delegate didLoadInterstitialAd];
}

- (void)interstitial:(nullable SMAInterstitial *)interstitial didFailWithError:(NSError *)error
{
    [self.smaatoWaterfallAdapter log: @"Interstitial ad failed to load with error: %@", error];
    
    MAAdapterError *adapterError = [SmaatoApplovinMediationAdapter toMaxError: error];
    [self.delegate didFailToLoadInterstitialAdWithError: adapterError];
}

- (void)interstitialWillAppear:(SMAInterstitial *)interstitial
{
    [self.smaatoWaterfallAdapter log: @"Interstitial ad will appear"];
}

- (void)interstitialDidAppear:(SMAInterstitial *)interstitial
{
    [self.smaatoWaterfallAdapter log: @"Interstitial ad displayed"];
}

- (void)interstitialDidClick:(SMAInterstitial *)interstitial
{
    [ self.smaatoWaterfallAdapter log: @"Interstitial ad clicked"];
}

- (void)interstitialWillLeaveApplication:(SMAInterstitial *)interstitial
{
    [self.smaatoWaterfallAdapter log: @"Interstitial ad will leave application"];
}

- (void)interstitialWillDisappear:(SMAInterstitial *)interstitial
{
    [self.smaatoWaterfallAdapter log: @"Interstitial ad will disappear"];
}

- (void)interstitialDidDisappear:(SMAInterstitial *)interstitial
{
    [self.smaatoWaterfallAdapter log: @"Interstitial ad hidden"];
}
@end

#pragma mark - Rewarded Delegate Methods

@implementation SmaatoAppLovinMediationRewardedAdDelegate

- (instancetype)initWithSmaatoWaterfallAdapter:(SmaatoApplovinMediationAdapter *)parentAdapter andNotify:(id<MARewardedAdapterDelegate>)delegate
{
    self = [super init];
    if ( self )
    {
        self.smaatoWaterfallAdapter = parentAdapter;
        self.delegate = delegate;
    }
    return self;
}

- (void)rewardedInterstitialDidLoad:(SMARewardedInterstitial *)rewardedInterstitial
{
    [self.smaatoWaterfallAdapter log: @"Rewarded ad loaded"];
    [self.delegate didLoadRewardedAd];
}

- (void)rewardedInterstitialDidFail:(nullable SMARewardedInterstitial *)rewardedInterstitial withError:(NSError *)error
{
    [self.smaatoWaterfallAdapter log: @"Rewarded ad failed to load with error: %@", error];
    
    MAAdapterError *adapterError = [SmaatoApplovinMediationAdapter toMaxError: error];
    [self.delegate didFailToLoadRewardedAdWithError: adapterError];
}

- (void)rewardedInterstitialDidTTLExpire:(SMARewardedInterstitial *)rewardedInterstitial
{
    [self.smaatoWaterfallAdapter log: @"Rewarded ad expired"];
    
}

- (void)rewardedInterstitialWillAppear:(SMARewardedInterstitial *)rewardedInterstitial
{
    [self.smaatoWaterfallAdapter log: @"Rewarded ad will appear"];
}

- (void)rewardedInterstitialDidAppear:(SMARewardedInterstitial *)rewardedInterstitial
{
    [self.smaatoWaterfallAdapter log: @"Rewarded ad displayed"];
    [self.delegate didDisplayRewardedAd];
}

- (void)rewardedInterstitialDidStart:(SMARewardedInterstitial *)rewardedInterstitial
{
    [self.smaatoWaterfallAdapter log: @"Reward ad video started"];
    [self.delegate didStartRewardedAdVideo];
}

- (void)rewardedInterstitialDidClick:(SMARewardedInterstitial *)rewardedInterstitial
{
    [self.smaatoWaterfallAdapter log: @"Rewarded ad clicked"];
    [self.delegate didClickRewardedAd];
}

- (void)rewardedInterstitialWillLeaveApplication:(SMARewardedInterstitial *)rewardedInterstitial
{
    [self.smaatoWaterfallAdapter log: @"Rewarded ad will leave application"];
}

- (void)rewardedInterstitialDidReward:(SMARewardedInterstitial *)rewardedInterstitial
{
    [self.smaatoWaterfallAdapter log: @"Rewarded ad video completed"];
    self.grantedReward = YES;
    [self.delegate didCompleteRewardedAdVideo];
    
}

- (void)rewardedInterstitialWillDisappear:(SMARewardedInterstitial *)rewardedInterstitial
{
    [self.smaatoWaterfallAdapter log: @"Rewarded ad will disappear"];
}
- (void)rewardedInterstitialDidDisappear:(SMARewardedInterstitial *)rewardedInterstitial
{
    if ( [self hasGrantedReward] || [self.smaatoWaterfallAdapter shouldAlwaysRewardUser] )
    {
        MAReward *reward = [self.smaatoWaterfallAdapter reward];
        [self.smaatoWaterfallAdapter log: @"Rewarded user with reward: %@", reward];
        [self.delegate didRewardUserWithReward: reward];
    }
    
    [self.smaatoWaterfallAdapter log: @"Rewarded ad hidden"];
    [self.delegate didHideRewardedAd];
}

@end



