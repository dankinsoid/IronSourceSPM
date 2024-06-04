//
//  APSAdMobCommonUtils.h
//  APSAdMobAdapterStatic
//
//  Copyright © 2023 Amazon.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DTBiOSSDK/DTBiOSSDK.h>
#import "APSAdNetworkExtras.h"

NS_ASSUME_NONNULL_BEGIN

@interface APSAdMobUtils : NSObject

+ (APSAdNetworkExtras * _Nullable)extrasWithSlotUUID:(NSString *)slotUUId
                                               width:(NSInteger)width
                                              height:(NSInteger)height;

+ (APSAdNetworkExtras * _Nullable)extrasWithSlotGroup:(NSString *)slotGroup
                                              privacy:(NSDictionary * _Nullable)privacyExtras;

+ (APSAdNetworkExtras * _Nullable)extrasWithSlotUUID:(NSString *)slotUUId
                                               width:(NSInteger)width
                                              height:(NSInteger)height
                                             privacy:(NSDictionary * _Nullable)privacyExtras;

+ (APSAdNetworkExtras * _Nullable)extrasWithSlotUUID:(NSString *)slotUUID
                                            adFormat:(APSAdFormat)adFormat;

+ (APSAdNetworkExtras * _Nullable)extrasWithSlotUUID:(NSString *)slotUUID;

+ (APSAdNetworkExtras * _Nullable)extrasWithSlotUUID:(NSString *)slotUUID
                                             privacy:(NSDictionary * _Nullable)privacyExtras;
+ (APSAdNetworkExtras * _Nullable)extrasWithSlotGroup:(NSString *)slotGroup;

@end

NS_ASSUME_NONNULL_END
