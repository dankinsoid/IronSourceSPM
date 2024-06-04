//
//  HYPRBrowserStateChangeDelegate.h
//  HyprMX-Framework
//
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <HyprMX/HYPRBrowserViewController.h>
@class HYPRWebView;

@protocol HYPRBrowserStateChangeDelegate <NSObject>

@required
-(void)browser:(id<HYPRBrowserViewControllerInterface>)browser
     dismissed:(BOOL)finished webView:(HYPRWebView *)webView API_AVAILABLE(ios(13.4));
-(void)didOpenUrlOutsideApplication;
@end
