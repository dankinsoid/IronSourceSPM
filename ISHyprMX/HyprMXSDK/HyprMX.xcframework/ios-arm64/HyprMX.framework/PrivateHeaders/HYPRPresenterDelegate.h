//
//  HYPRPresenterDelegate.h
//  HyprMX-Framework
//
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <HyprMX/HYPRPresentationAdapterProtocol.h>
@class HYPRBrowserViewController, HYPRPresentationStateChangeEvent, HYPRWebView, HYPRPresentationAdapterDelegateImplementation, HYPROrientation;

@protocol HYPRWebViewDelegate <NSObject>

@required
-(void)destroy;
-(void)updateDelegate:(id<HYPRPresentationAdapterDelegate>)presenterDelegate
          viewModelId:(NSString *)viewModelId
          orientation:(HYPROrientation *)orientation;
-(void)documentComplete;
-(BOOL)navigateWebViewForward;
-(BOOL)navigateWebViewBack;
-(void)boundsChanged:(CGRect)newBounds;
-(BOOL)shouldTakeFocus;
-(BOOL)shouldKeepFocus;
-(BOOL)shouldLoadAboutBlank;
-(NSString *)webviewDestroyScript;
@end
