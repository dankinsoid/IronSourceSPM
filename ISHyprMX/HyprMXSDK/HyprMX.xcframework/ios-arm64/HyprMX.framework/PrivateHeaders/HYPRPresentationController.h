//
//  HYPRPresentationController.h
//  HyprMX-SDK
//
//  Created by Sean Reinhardt on 2/26/18.
//  Copyright © 2018 HyprMX Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <HyprMX/HYPRPresentationControllerResultDelegate.h>
#import <HyprMX/HYPRPresentationResultsDelegate.h>
#import <HyprMX/HYPRAvailability.h>

@class HyprMXPlacement, HYPRAdClosedAction, HYPRJSContext, HYPRPreloadController;

HYPR_CLASS_AVAILABLE_IOS
@interface HYPRPresentationController : NSObject <HYPRPresentationResultsDelegate>

- (instancetype)initWithContext:(HYPRJSContext *)context
                         userId:(NSString *)userId
                  distributorId:(NSString *)distributorId
              preloadController:(HYPRPreloadController *)preloadController
                       delegate:(id <HYPRPresentationControllerResultDelegate>)delegate;
- (void)showAdForPlacement:(HyprMXPlacement *)placement
            viewController:(UIViewController *)viewController;
- (void)removeNotificationObservers;

// Helper to find active window
+ (UIWindow *)activeWindow;

+ (UIInterfaceOrientation)currentOrientation;

// NotificationName helpers return the UIScene or UIApplication notification depending on OS version
+ (NSNotificationName)hyprAdDidActivateNotification;
+ (NSNotificationName)hyprAdWillDeactivateNotification;
+ (NSNotificationName)hyprAdWillForegroundNotification;
+ (NSNotificationName)hyprAdDidBackgroundNotification;

@end
