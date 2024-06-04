//
//  HyprMXPlacement.h
//  HyprMX
//

#import <UIKit/UIKit.h>
@class HYPRController;

typedef enum {
    INVALID = 0,
    INTERSTITIAL,
    REWARDED,
    BANNER
} HyprMXPlacementType;

typedef enum {
    NO_FILL = 0,
    DISPLAY_ERROR,
    PLACEMENT_DOES_NOT_EXIST,
    AD_SIZE_NOT_SET,
    PLACEMENT_NAME_NOT_SET,
    SDK_NOT_INITIALIZED
} HyprMXError;

@protocol HyprMXPlacementDelegate;

@interface HyprMXPlacement : NSObject

/** Gets the type of placement */
@property (assign, nonatomic, readonly) HyprMXPlacementType placementType;

/** Gets the Name of the placement */
@property (strong, nonatomic, readonly, nonnull)  NSString *placementName;

/** delegate for this placement */
@property (weak, nonatomic, nullable) id<HyprMXPlacementDelegate> placementDelegate;

/**  Loads the ads */
- (void)loadAd;

/**  Loads the ads */
- (BOOL)loadAdWithBidResponse:(nonnull NSString *)bidResponse;

/**
 * Checks to see if there is an ad available
 * @return True if an ad can be shown, false otherwise
 */
- (BOOL)isAdAvailable;

/**
* Shows the ad from a specified UIViewController
  * You may call this API with a nil viewController and the Ad will be show from the top UIViewController on the UIWindow.keyWindow
 * For rewarded placement:
 *  HyprMXPlacementListener.adWillStartForPlacement:
 *  HyprMXPlacementListener.oadDidRewardForPlacement:rewardName:rewardValue:
 *  HyprMXPlacementListener.adDidCloseForPlacement:didFinishAd:
 *
 * For interstitial placement:
 *  HyprMXPlacementListener.adWillStartForPlacement:
 *  HyprMXPlacementListener.adDidCloseForPlacement:didFinishAd:
 *
 * No ad to display or error occurred during presentation
 *  HyprMXPlacementListener.adWillStartForPlacement:
 *  HyprMXPlacementListener.adDisplayErrorForPlacement:error:
 *  HyprMXPlacementListener.adDidCloseForPlacement:didFinishAd:
 *
 * @param viewController - The UIViewController to present the Ad from.
*/
- (void)showAdFromViewController:(nullable UIViewController *)viewController;

@end

@protocol HyprMXPlacementDelegate <NSObject>

/**
 * The ad is about to start showing
 * @param placement The placement being shown
 */
- (void)adWillStartForPlacement:(nonnull HyprMXPlacement *)placement;

/**
 * Presentation related to this placement has finished.
 * @param placement The placement that presented
 * @param finished true if ad was finished, false if it was canceled
 */
- (void)adDidCloseForPlacement:(nonnull HyprMXPlacement *)placement didFinishAd:(BOOL)finished;

/**
 * An ad is available for the placement
 * @param placement The placement that was loaded
 */
- (void)adAvailableForPlacement:(nonnull HyprMXPlacement *)placement;

/**
 * There is no fill for the placement
 * @param placement The placement that was loaded
 */
- (void)adNotAvailableForPlacement:(nonnull HyprMXPlacement *)placement;

@optional

/**
 * There was an error with the placement during presentation.
 * @note This method and adDisplayErrorForPlacement:error: are both called when an error is received.
 *
 * @param error The error that occured
 * @param placement The placement with the error
 */
- (void)adDisplayError:(nonnull NSError *)error placement:(nonnull HyprMXPlacement *)placement;

/**
 * There was an error with the placement during presentation.
 * @note You can use either this method or adDisplayError:placement: to receive error events, but this method will be deprecated in the future.
 *
 * @param placement The placement with the error
 * @param hyprMXError The error that occured
 */
- (void)adDisplayErrorForPlacement:(nonnull HyprMXPlacement *)placement error:(HyprMXError)hyprMXError;

/**
 * The ad was rewarded for the placement and will be called before ad finished is called
 * This will only be called for rewarded placements
 * @param placement The placement that was rewarded
 * @param rewardName The name of the reward
 * @param rewardValue The value of the reward
 */
- (void)adDidRewardForPlacement:(nonnull HyprMXPlacement *)placement rewardName:(nullable NSString *)rewardName rewardValue:( NSInteger)rewardValue;

/**
 * An ad is no longer available for the placement
 * @param placement The placement that expired
 */
- (void)adExpiredForPlacement:(nonnull HyprMXPlacement *)placement;

@end
