//
//  HyprMX.h
//  HyprMX
//
#import <UIKit/UIKit.h>
//! Project version number for HyprMX_SDK.
FOUNDATION_EXPORT double HyprMXVersionNumber;

//! Project version string for HyprMX_SDK.
FOUNDATION_EXPORT const unsigned char HyprMXVersionString[];

#import <HyprMX/HyprMXPlacement.h>
#import <Foundation/Foundation.h>

extern CGSize const kHyprMXAdSizeShort;
extern CGSize const kHyprMXAdSizeBanner;
extern CGSize const kHyprMXAdSizeMediumRectangle;
extern CGSize const kHyprMXAdSizeLeaderBoard;
extern CGSize const kHyprMXAdSizeSkyScraper;

@protocol HyprMXInitializationDelegate
@optional
/**
 * The initialization has completed successfully
 */
- (void)initializationDidComplete;

/**
 * The initialization has failed
 */
- (void)initializationFailed;
@end

@protocol HyprMXAudioChangeDelegate
- (void)adAudioWillStart;
- (void)adAudioDidEnd;
@end

@class HyprMXPlacement;
@interface HyprMX : NSObject

typedef enum {
    HYPRLogLevelError = 0, // Messages at this level get logged all the time.
    HYPRLogLevelVerbose,   //                               ... only when verbose logging is turned on.
    HYPRLogLevelDebug      //                               ... in debug mode.
} HYPRLogLevel;

typedef enum {
    NOT_INITIALIZED = 0,    // HyprMX has not been initialized yet.
    INITIALIZING,           // Initialiation is in progress.
    INITIALIZATION_FAILED,  // Initialization failed.
    INITIALIZATION_COMPLETE // Initialization completed successfully.
} HyprMXState;

typedef enum {
    CONSENT_STATUS_UNKNOWN = 0,  // consent has not been collected from the user
    CONSENT_GIVEN,               // user has granted consent
    CONSENT_DECLINED             // user has declined
} HyprConsentStatus;

extern NSString * _Nonnull const HyprMXMediationProviderAdmob;
extern NSString * _Nonnull const HyprMXMediationProviderApplovinMax;
extern NSString * _Nonnull const HyprMXMediationProviderFyber;
extern NSString * _Nonnull const HyprMXMediationProviderIronSource;
extern NSString * _Nonnull const HyprMXMediationProviderMopub;
extern NSString * _Nonnull const HyprMXMediationProviderUnity;

@property (nullable, class, nonatomic) NSObject<HyprMXAudioChangeDelegate>* audioChangeDelegate;

/**
 * Initializes the SDK.
 *
 * @param distributorId The application identifier.
 * @param userId Unique ID to identify the user
 * @param initializationDelegate The initialization listener the SDK should callback to
 */
+ (void)initializeWithDistributorId:(nonnull NSString *)distributorId
                             userId:(nonnull NSString *)userId
             initializationDelegate:(nullable id<HyprMXInitializationDelegate>)initializationDelegate;

/**
 * Initializes the SDK with param for GDPR compliance.
 *
 * @param distributorId The application identifier.
 * @param userId Unique ID to identify the user
 * @param consentStatus for GDPR compliance
 * @param initializationDelegate The initialization listener the SDK should callback to
 */
+ (void)initializeWithDistributorId:(nonnull NSString *)distributorId
                             userId:(nonnull NSString *)userId
                      consentStatus:(HyprConsentStatus)consentStatus
             initializationDelegate:(nullable id<HyprMXInitializationDelegate>)initializationDelegate;

/**
 * Initializes the SDK with params for GDPR and Age Restricted User compliance.
 *
 * @param distributorId The application identifier.
 * @param userId Unique ID to identify the user
 * @param consentStatus for GDPR compliance
 * @param isAgeRestrictedUser Indicates if the user should be handled as Age Restricted.
 * @param initializationDelegate The initialization listener the SDK should callback to
 */
+ (void)initializeWithDistributorId:(nonnull NSString *)distributorId
                             userId:(nonnull NSString *)userId
                      consentStatus:(HyprConsentStatus)consentStatus
                  ageRestrictedUser:(BOOL)isAgeRestrictedUser
             initializationDelegate:(nullable id<HyprMXInitializationDelegate>)initializationDelegate;
/**
 * Gets the placement object associated with the placement ID
 *
 * @param placementID The ID of the placement to retrieve
 * @return The placement with the corresponding ID.  If not found, returns a HyprMXInvalidPlacement
 */
+ (nullable HyprMXPlacement *)getPlacement:(nonnull NSString *)placementID;

/**
 * Gets all available placements
 *
 * @return an array of HyprMXPlacement objects
 */
+ (nullable NSArray<HyprMXPlacement*>*)placements;

/**
 * Gets the current initialization status.
 *
* @return HyprMXState value of the initialization status
 */
+ (HyprMXState)initializationStatus;

/**
 * Gets the current SDK version String.
 *
* @return NSString version.
 */
+ (nonnull NSString *)versionString;

/**
 * Gets a session token for bidding.
 *
* @return NSString sessionToken.
 */
+ (nullable NSString *)sessionToken;

/**
 * Sets logging to a specific level.
 *
 * @param level The log level to log at. Defaults to HYPRLogLevelError.
 * @discussion Level should not be set above HYPRLogLevelError in production, as excessive logging can hurt performance.
 */
+ (void)setLogLevel:(HYPRLogLevel)level;

/*
 * setter for GDPR compliance as determined by publisher
 * @param consentStatus for GDPR compliance
 * @discussion setting consentStatus will invalidate any existing placements,
    loadAd will have to be called again to show an ad
 */
+ (void)setConsentStatus:(HyprConsentStatus)consentStatus;

/**
   * Set the version of unity used to build application
   */
+ (void)setUnityVersion:(nullable NSString *)version;

  /**
   * Set the mediator version information
   *
   * @param mediator The mediator managing HyprMX.  Use one from HyprMXMediationProvider or provide your own
   * @param sdkVersion  The version of the mediator SDK
   * @param adapterVersion The version of the mediation adapter
   */
+ (void)setMediationProvider:(nullable NSString*)mediator
          mediatorSDKVersion:(nullable NSString*)sdkVersion
              adapterVersion:(nullable NSString*)adapterVersion;
@end
