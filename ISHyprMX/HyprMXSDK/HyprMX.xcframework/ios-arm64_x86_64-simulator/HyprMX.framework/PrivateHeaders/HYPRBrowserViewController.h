//
//  HYPRBrowserViewController.h
//  HyprMX-Framework
//
//  Created by Sean Reinhardt on 4/8/21.
//  Copyright © 2021 HyprMX Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HyprMX/HYPRPresenterDelegate.h>
#import <HyprMX/HYPRAvailability.h>
#import <HyprMX/HYPRWebView.h>

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(ios(13.4))
@protocol HYPRBrowserViewControllerInterface <NSObject>
@property (strong, nonatomic, nullable) HYPRWebView *webView;
- (void)notifyBrowserWillClose;
@end

HYPR_CLASS_AVAILABLE_IOS
@interface HYPRBrowserViewController : UIViewController
<HYPRBrowserViewControllerInterface>
@end

NS_ASSUME_NONNULL_END
