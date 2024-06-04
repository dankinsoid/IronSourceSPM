//
//  HYPROrientation.h
//  HyprMX-Framework
//
//  Created by Sean Reinhardt on 12/1/20.
//  Copyright © 2020 HyprMX Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HyprMX/HYPRAvailability.h>
NS_ASSUME_NONNULL_BEGIN

@protocol HYPRApplicationOrientationSupport <NSObject>
- (UIInterfaceOrientationMask)supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window;
@property(nullable, nonatomic, assign) id<UIApplicationDelegate> delegate;
- (void)openURL:(NSURL*)url options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *)options completionHandler:(void (^ __nullable)(BOOL success))completion API_AVAILABLE(ios(10.0)) NS_EXTENSION_UNAVAILABLE_IOS("");
@end
HYPR_CLASS_AVAILABLE_IOS
@interface HYPROrientation : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithApplication:(id<HYPRApplicationOrientationSupport>)app window:(UIWindow *)window;
- (instancetype)initWithApp:(UIApplication*)app window:(nullable UIWindow *)window;
- (UIInterfaceOrientationMask)supportedOrientations;
- (NSArray<NSString*>*)orientationList;
- (BOOL)isPortraitSupported;

@property (nonatomic, readonly) UIInterfaceOrientationMask mask;
- (UIInterfaceOrientation)preferredInterfaceOrientation;
- (BOOL)shouldAutorotate;
-(void)setDesiredOrientationMask:(UIInterfaceOrientationMask)mask;
-(void)setDesiredOrientationMaskWithOrientation:(UIInterfaceOrientation)orientation;

@end

NS_ASSUME_NONNULL_END
