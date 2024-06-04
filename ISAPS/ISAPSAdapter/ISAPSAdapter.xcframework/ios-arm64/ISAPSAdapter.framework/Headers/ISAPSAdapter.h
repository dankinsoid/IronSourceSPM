//
//  ISAPSAdapter.h
//  ISAPSAdapter
//
//  Copyright © 2024 ironSource Mobile Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IronSource/ISBaseAdapter+Internal.h>
#import <DTBiOSSDK/DTBiOSSDK.h>

static NSString * const APSAdapterVersion = @"4.3.13";
static NSString * Githash = @"7a53c5c";

@import CoreLocation;
@import CoreTelephony;
@import MediaPlayer;
@import StoreKit;
@import SystemConfiguration;
@import QuartzCore;

@interface ISAPSAdapter : ISBaseAdapter

+ (NSString *)getErrorFromCode:(DTBAdErrorCode)errorCode;

@end

