//
//  ISMaioAdapter.h
//  ISMaioAdapter
//
//  Copyright © 2023 ironSource Mobile Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IronSource/ISBaseAdapter+Internal.h>

static NSString * const MaioAdapterVersion = @"4.1.11";
static NSString * Githash = @"a4229ff49";

//System Frameworks For Maio Adapter
@import AdSupport;
@import AVFoundation;
@import CoreMedia;
@import MobileCoreServices;
@import StoreKit;
@import SystemConfiguration;
@import UIKit;
@import WebKit;

@interface ISMaioAdapter : ISBaseAdapter

@end
