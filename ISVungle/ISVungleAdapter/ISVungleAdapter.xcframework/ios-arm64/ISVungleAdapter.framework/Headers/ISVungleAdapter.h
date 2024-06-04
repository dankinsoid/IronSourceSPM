//
//  ISVungleAdapter.h
//  ISVungleAdapter
//
//  Copyright © 2023 ironSource Mobile Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IronSource/ISBaseAdapter+Internal.h>

static NSString * const VungleAdapterVersion = @"4.3.35";
static NSString * Githash = @"1cd71f3";

//System Frameworks For Vungle Adapter

@import AdSupport;
@import AudioToolbox;
@import AVFoundation;
@import CFNetwork;
@import CoreGraphics;
@import CoreMedia;
@import Foundation;
@import MediaPlayer;
@import QuartzCore;
@import StoreKit;
@import SystemConfiguration;
@import UIKit;
@import WebKit;

@interface ISVungleAdapter : ISBaseAdapter

@end
