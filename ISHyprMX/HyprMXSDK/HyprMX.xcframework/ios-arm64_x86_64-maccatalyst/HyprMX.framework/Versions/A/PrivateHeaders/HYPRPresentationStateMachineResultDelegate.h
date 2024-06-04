//
//  HYPRPresentationStateMachineResultDelegate.h
//  HyprMX-Framework
//
#import <UIKit/UIKit.h>
@class HYPRWebView;
@protocol HYPRPresentationStateMachineResultDelegate <NSObject>
-(void)stateMachinePresentedController:(nonnull UIViewController *)controller;
-(void)stateMachineDismissedControllerWithWebView:(nullable HYPRWebView *)webView API_AVAILABLE(ios(13.4));
-(void)stateMachineWillOpenUrlOutsideApp;
-(void)stateMachineWillPresentOverlayOnWindow;
@end
