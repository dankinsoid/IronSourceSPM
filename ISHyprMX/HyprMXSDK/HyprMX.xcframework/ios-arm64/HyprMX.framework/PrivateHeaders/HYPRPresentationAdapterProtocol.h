//
//  HYPRPresentationAdapterProtocol.h
//  HyprMX-Framework
//
//  Created by Sean Reinhardt on 9/2/22.
//  Copyright © 2022 HyprMX Mobile LLC. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
NS_ASSUME_NONNULL_BEGIN
@class HYPRWebView, HYPRJSContext;
@protocol HYPRPresentationAdapterDelegate;

@protocol HYPRPresentationAdapterResultDelegate <NSObject>
-(void)stateMachinePresentedController:(nonnull UIViewController *)controller;
-(void)stateMachineDismissedControllerWithWebView:(nullable HYPRWebView *)webView shouldNotifyClose:(BOOL)shouldNotify API_AVAILABLE(ios(13.4));
-(void)stateMachineWillOpenUrlOutsideApp;
-(void)stateMachineWillPresentOverlayOnWindow;
@end

@protocol HYPRPresentationAdapterProtocol <NSObject>
@property (strong, nonatomic, readonly, nullable) NSURL *url;
@property (strong, nonatomic, readonly, nullable) UIViewController * presentation;
@property (strong, nonatomic, readonly, nullable) UIViewController * baseController;
@property (weak, nonatomic) id<HYPRPresentationAdapterDelegate> presentationDelegate;
-(void)presentWithResponder:(nullable UIResponder *)responder;
@end

@protocol HYPRPresentationAdapterDelegate <NSObject>
@property (weak, nonatomic) id<HYPRPresentationAdapterResultDelegate> resultsDelegate;
-(instancetype)initWithResultsDelegate:(id<HYPRPresentationAdapterResultDelegate>)resultsDelegate;
-(BOOL)canShowPresentation;
-(void)holdPresentation:(id<HYPRPresentationAdapterProtocol>)adapter;
-(BOOL)showHeldPresentation;
-(void)showPresentation:(UIViewController *)presentation forAdapter:(id<HYPRPresentationAdapterProtocol>)adapter;
-(BOOL)presentOutsideApplication:(id<HYPRPresentationAdapterProtocol>)adapter;
-(void)showAccessoryPresentation:(UIViewController *)presentation  base:(UIViewController *)base;
-(void)adapterCompletedPresentation:(id<HYPRPresentationAdapterProtocol>)adapter;
-(void)fullscreenOfferWillClose;
-(void)dismissOverlay;
-(BOOL)presentOverlay:(SKOverlay *)overlay forAdapter:(id<HYPRPresentationAdapterProtocol>)adapter API_AVAILABLE(ios(14.0));
@end

/**
 * The Protocols below are used to expose SDKs Swift objects to Objective-C via Protocol conformance.
 * The ObjC @interface CLASS_NAME must match the @objc(CLASS_NAME) annotation added to the Swift classes for proper linking
 *
 * NOTE: Although its not standared to expose initializers through protocols, this is required since the protocol is doing interfacing between the languages
 */

@interface HYPRPresentationAdapterDelegateImplementation : NSObject<HYPRPresentationAdapterDelegate>
@end


@protocol HYPRPresentationAdapterOutsideAppProtocol <HYPRPresentationAdapterProtocol>
-(instancetype)init:(NSString *)url
presentationDelegate:(id<HYPRPresentationAdapterDelegate>)presentationDelegate;
@end

@interface HYPRPresentationAdapterOutsideApp: NSObject<HYPRPresentationAdapterOutsideAppProtocol>
@end


@protocol HYPRPresentationAdapterSafariBrowserProtocol <HYPRPresentationAdapterProtocol>
-(instancetype)init:(NSString *)url
presentationDelegate:(id<HYPRPresentationAdapterDelegate>)presentationDelegate;
@end

@interface HYPRSafariBrowserPresentation: NSObject<HYPRPresentationAdapterSafariBrowserProtocol>
@end

@protocol HYPRPresentationAdapterHyprMXBrowserProtocol <HYPRPresentationAdapterProtocol>
-(instancetype)init:(NSString *)placement
           browserVmId:(NSString *)baseAdId
            context:(HYPRJSContext *)context
presentationDelegate:(id<HYPRPresentationAdapterDelegate>)presentationDelegate
             window:(nullable UIWindow *)window
               mask:(UIInterfaceOrientationMask)mask;
-(nullable WKWebView *)createWebView:(WKWebViewConfiguration *)config;
-(nullable UIViewController *)setBase:(nullable UIResponder *)responder;
@end

@interface HYPRBrowserPresentation: NSObject<HYPRPresentationAdapterHyprMXBrowserProtocol>
@end

@protocol HYPRPresentationAdapterModalAlertProtocol <HYPRPresentationAdapterProtocol>
-(instancetype)initWithModalView:(UIViewController *)modal presentationDelegate:(id<HYPRPresentationAdapterDelegate>)presentationDelegate;
-(BOOL)presentModalWithResponder:(nullable UIResponder *)responder;
@end

@interface HYPRModalAlertPresentation: NSObject<HYPRPresentationAdapterModalAlertProtocol>
@end

@protocol HYPRPresentationAdapterAppStoreProtocol <HYPRPresentationAdapterProtocol>
-(instancetype)init:(NSString *)json
presentationDelegate:(id<HYPRPresentationAdapterDelegate>)presentationDelegate;
@end

@interface HYPRAppStorePresentation: NSObject<HYPRPresentationAdapterAppStoreProtocol>
@end
NS_ASSUME_NONNULL_END
