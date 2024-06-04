//
//  HYPRBrowserViewModelConnector.h
//  HyprMX-Framework
//
//  Created by Sean Reinhardt on 4/16/21.
//  Copyright © 2021 HyprMX Mobile LLC. All rights reserved.
//

#import <HyprMX/HYPRViewModelConnector.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HYPRBrowserViewModelInterface <NSObject>
- (void)onBrowserReady;
- (void)onSharePressed;
- (void)onClose;
- (void)onNavigateBackPressed;
- (void)onNavigateForwardPressed;
- (void)onBackPressed;
@end
HYPR_CLASS_AVAILABLE_IOS
@interface HYPRBrowserViewModelConnector : HYPRViewModelConnector <HYPRBrowserViewModelInterface>
@property (strong, nonatomic, readonly) NSString *baseAdId;
- (instancetype)initWithContext:(HYPRJSContext *)context
                       baseAdId:(NSString *)baseAdId
                          queue:(NSOperationQueue *)queue;
@end

NS_ASSUME_NONNULL_END
