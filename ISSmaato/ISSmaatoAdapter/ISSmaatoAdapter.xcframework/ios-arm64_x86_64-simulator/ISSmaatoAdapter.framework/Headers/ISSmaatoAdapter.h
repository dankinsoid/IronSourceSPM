//
//  ISSmaatoAdapter.h
//  ISSmaatoAdapter
//
//  Copyright © 2023 ironSource Mobile Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IronSource/ISBaseAdapter+Internal.h>

static NSString * const SmaatoAdapterVersion = @"4.3.13";
static NSString * Githash = @"28f8025";

//System Frameworks For Smaato Adapter

@import AdSupport;
@import AVFoundation;
@import CoreMedia;
@import CoreTelephony;
@import StoreKit;
@import SafariServices;
@import SystemConfiguration;
@import WebKit;

@interface ISSmaatoAdapter : ISBaseAdapter

@end

