//
//  HYPREventPoster.h
//  HyprMX-Framework
//
//  Created by Sean Reinhardt on 3/29/21.
//  Copyright © 2021 HyprMX Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HyprMX/HYPRAvailability.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString * const kHYPRContainerVisibleKey;
extern NSString * const kHYPROnLifecycleEventKey;
extern NSString * const kHYPROnParentViewChangeKey;

extern NSString * const kHYPRBindFullScreenFunction;
extern NSString * const kHYPRBindBannerFunction;
extern NSString * const kHYPRGetViewModelFunction;
@protocol HYPRBaseAdViewModelInterface <NSObject>
- (void)onLifecycleEvent:(NSDictionary *)arg;
- (void)containerVisibleChange:(NSDictionary *)arg;
- (void)containerSizeChange:(NSDictionary *)arg;
- (void)nativeBrowserPresented:(NSDictionary *)arg;
- (void)onParentViewChangeEvent:(NSDictionary *)arg;
- (void)onClose;
- (void)onModalClosed;
- (void)windowOpenAttempt:(NSDictionary *)arg;
@end

@protocol HYPRBannerViewModelInterface <NSObject>
- (void)loadAd:(NSDictionary *)arg;
- (void)setUserInteracted:(NSDictionary *)arg;
- (void)onVisibleEvent:(NSDictionary *)data;
-(BOOL)hasPlacement;
@end

/** Equivalent to FullScreenSharedInterface in Android SDK */
@protocol HYPRFullScreenViewModelInterface <NSObject>
@property(strong, nonatomic, readonly) NSString *thankYouUrl;
@property(strong, nonatomic, readonly) NSString *viewingId;
@property(strong, nonatomic, readonly) NSString *recoveryParams;
@property(nonatomic, readonly) BOOL adCompleted;
@property(nonatomic, readonly) BOOL payoutComplete;
- (BOOL)isPageReady;
- (void)cancelDialogExitPressed;
- (void)nativeClosePressed;
- (void)onErrorDialogOKPressed;
- (void)onBackButtonPressed;
- (void)unknownErrorOccurred:(NSString *)errorString;
- (void)internetLossDetected;
@end

/** Equivalent to WebTrafficSharedInterface in Android SDK */
@protocol HYPROpenMeasurementViewModelInterface <NSObject>
@property(strong, nonatomic, readonly) NSString *openMeasurementCustomData;
@end

/** Equivalent to WebTrafficSharedInterface in Android SDK */
@protocol HYPRWebTrafficViewModelInterface <NSObject>
- (void)webTrafficPageMinTimeComplete;
- (void)didTapNext;
- (void)didTapFinish;
- (void)didTapClose;
@end
@class HYPRJSContext;
HYPR_CLASS_AVAILABLE_IOS
@interface HYPRViewModelConnector : NSObject <
HYPRBaseAdViewModelInterface
> {
@protected NSString *_viewModelIdentifier;
}
@property (weak, nonatomic, readonly) HYPRJSContext *context;
@property (strong, nonatomic) NSString *placementName;
@property (strong, nonatomic, readonly) NSString *viewModelIdentifier;
@property (strong, nonatomic, readonly) NSString *postFunction;
@property (strong, nonatomic, readonly) NSOperationQueue *queue;
- (instancetype)initWithContext:(HYPRJSContext *)context
                    viewModelId:(nullable NSString *)viewModelId
                          queue:(NSOperationQueue *)queue;

/**
  * bindViewModel is the general API, it sets the viewModel identifier and native object.
  * If they can't be done serially, getViewModelId and then bindNativeObject may be called individually, and getViewModelId must be invoked first
 */
-(BOOL)bindNativeObject:(nullable NSObject *)nativeObject hash:(NSUInteger)hash;
- (void)destroyViewModel;
- (void)removeObjectByHash:(NSUInteger)hash;
@end

NS_ASSUME_NONNULL_END
