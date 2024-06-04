//
//  ISMyTargetAdapter.h
//  ISMyTargetAdapter
//
//  Copyright © 2023 ironSource Mobile Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IronSource/ISBaseAdapter+Internal.h>

static NSString * const MyTargetAdapterVersion = @"4.1.21";
static NSString * Githash = @"c6a194c";

//System Frameworks For MyTarget Adapter
@import AdSupport;
@import AVFoundation;
@import CoreGraphics;
@import CoreMedia;
@import CoreTelephony;
@import SafariServices;
@import StoreKit;
@import SystemConfiguration;


@interface ISMyTargetAdapter : ISBaseAdapter

@end
