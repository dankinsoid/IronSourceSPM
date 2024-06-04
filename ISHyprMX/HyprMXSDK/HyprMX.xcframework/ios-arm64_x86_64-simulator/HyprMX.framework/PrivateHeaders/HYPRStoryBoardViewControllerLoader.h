//
//  HYPRStoryBoard.h
//  HyprMX-Framework
//
//  Created by Sean Reinhardt on 4/8/21.
//  Copyright © 2021 HyprMX Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <HyprMX/HYPRAvailability.h>
#import <HyprMX/HYPRPresenterDelegate.h>
#import <HyprMX/HYPRBrowserStateChangeDelegate.h>
#import <HyprMX/HYPRBrowserViewController.h>
@class HYPROrientation, HYPRJSContext;
NS_ASSUME_NONNULL_BEGIN

/**
 This class wraps the implementation for accessing our storyboard from the SDK's bundle.
 
 Also acts as a factory for initializing ViewControllers defined in the StoryBoard
 */
HYPR_CLASS_AVAILABLE_IOS
@protocol HYPRStoryBoardViewControllerLoader
+(UIStoryboard *)storyboard;
+(nullable id<HYPRBrowserViewControllerInterface>)browserWithBaseAdId:(NSString *)baseAdId
                                                              context:(HYPRJSContext *)contex
                                                        webViewConfig:(WKWebViewConfiguration *)webView
                                                          orientation:(HYPROrientation *)orientation
                                                             delegate: (id<HYPRBrowserStateChangeDelegate>)delegate;
@end

@interface HYPRStoryBoard : NSObject <HYPRStoryBoardViewControllerLoader>
@end
NS_ASSUME_NONNULL_END
