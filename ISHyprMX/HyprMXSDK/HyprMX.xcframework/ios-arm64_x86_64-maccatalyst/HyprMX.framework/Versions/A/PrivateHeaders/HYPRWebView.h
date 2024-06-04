//
//  HYPRWebView.h
//  HyprMX-SDK
//
//  Created by Ben Balcomb on 2/11/19.
//  Copyright © 2019 HyprMX Mobile LLC. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <HyprMX/HYPRAvailability.h>
#import <HyprMX/HYPRPresenterDelegate.h>
#import <HyprMX/HYPROrientation.h>
#import <HyprMX/HYPRPresentationAdapterProtocol.h>

extern NSString * _Nonnull const kHYPRWebViewDisplayModeBaseAd;
extern NSString * _Nonnull const kHYPRWebViewDisplayModeSharing;
extern NSString * _Nonnull const kHYPRWebViewDisplayModeWebTrafficPage;
extern NSString * _Nonnull const kHYPRWebViewDisplayModeBannerAd;

NS_ASSUME_NONNULL_BEGIN
@class HYPRMutableURLRequest, HYPRWebView, HYPRJSContext, HYPRWebViewUpdateConfiguration;

HYPR_CLASS_AVAILABLE_IOS
@interface HYPRWebView : UIView

/**
 * Setting this property causes HYPROfferViewController
 * to retain the web view for the given value in seconds
 * as needed for Open Measurement processing to finish.
 */
@property (strong, nonatomic) NSNumber *omRetainTime;

@property (nullable, strong, nonatomic) id<HYPRWebViewDelegate> presenter;
@property (weak, nonatomic) WKWebView *internalWebView;
@property (nullable, nonatomic, copy) void(^hyprPagehideComplete)(void);

-(void)claimWithBaseDelegate:(id<HYPRPresentationAdapterDelegate>)delegate
                  viewModelId:(NSString *)viewModelId
                  orientation:(HYPROrientation *)orientation;

-(void)showPreloadedWebViewWithBaseDelegate:(id<HYPRPresentationAdapterDelegate>)delegate
                                viewModelId:(NSString *)viewModelId
                                orientation:(HYPROrientation *)orientation;

- (void)injectJavaScript:(NSString *)script;

- (void)postWebViewEventOnObject:(NSString *)object
                       eventName:(NSString *)event
                          detail:(NSString *)detail;

- (BOOL)loadUrl:(NSString *)urlString;
- (void)loadNewWebViewWithRequest:(NSURLRequest *)request;
- (BOOL)loadData:(NSString *)data url:(nullable NSString *)url;
- (void)updatePinchEnabled:(BOOL)isEnabled;

-(void)reload;
-(void)goBack;
-(void)goForward;
- (BOOL)userAgentIndicatesAppStoreResolver;
- (NSString *)currentWebViewUrl;
-(NSDictionary *)webViewHistoryData;
-(NSDictionary *)webViewHistoryState;
-(void)getReadyStateWithCompletion:(void (^ _Nullable)( NSString * _Nullable resultState))completionHandler;
-(void)checkWebViewForAppJSObjectWithCompletion:(void (^ _Nullable)( BOOL isAppJSMissing))completionHandler;
- (void)updateWebViewConfiguration:(HYPRWebViewUpdateConfiguration *)event;

+ (HYPRWebView *)webViewWithConfiguration:(nonnull WKWebViewConfiguration *)configuration
                                  context:(HYPRJSContext *)context
                                 baseAdId:(nullable NSString *)baseAdID
                              displayMode:(NSString *)displayMode
                        presenterDelegate:(nullable id<HYPRPresentationAdapterDelegate>)presenterDelegate
                              orientation:(nullable HYPROrientation *)orientation;

-(void)destroy:(BOOL)shouldLoadBlank;
-(void)removeScriptMessageHandler;
-(void)onPageHidden;
@end

NS_ASSUME_NONNULL_END
