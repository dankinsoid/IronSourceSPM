//
//  ISHyprMXAdapter.h
//  ISHyprMXAdapter
//
//  Copyright © 2023 ironSource Mobile Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IronSource/ISBaseAdapter+Internal.h>
#import <IronSource/IronSource.h>

static NSString * const HyprMXAdapterVersion = @"4.3.5";
static NSString * Githash = @"6bc35d8";

//System Frameworks For HyprMX Adapter

@import AdSupport;
@import AVFoundation;
@import CoreGraphics;
@import CoreMedia;
@import CoreTelephony;
@import EventKit;
@import EventKitUI;
@import Foundation;
@import JavaScriptCore;
@import MessageUI;
@import MobileCoreServices;
@import QuartzCore;
@import SafariServices;
@import StoreKit;
@import SystemConfiguration;
@import UIKit;
@import WebKit;

@interface ISHyprMXAdapter : ISBaseAdapter

@end
