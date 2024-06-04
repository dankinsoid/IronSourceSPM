//
//  HyprMXSingletonDelegate.h
//  HyprMX-Framework
//
//  Created by Sean Reinhardt on 6/15/22.
//  Copyright © 2022 HyprMX Mobile LLC. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <HyprMX/HyprMX.h>
#import <HyprMX/HYPRJSContextSource.h>
#ifndef HyprMXSingletonDelegate_h
#define HyprMXSingletonDelegate_h
@class HYPRController;
extern NSString *const kHyprControllerDeallocNotification;
@protocol HyprMXSingletonDelegate <NSObject>
@property (strong, nonatomic) NSObject<HYPRJSContextSource> *controller;
@property (strong, nonatomic) NSNotificationCenter *hyprNotificationCenter;
+ (nullable HyprMX *)sharedInstance;
@end

@interface HyprMX(HyprMXSingletonDelegate) <HyprMXSingletonDelegate>
@end
#endif /* HyprMXSingletonDelegate_h */
