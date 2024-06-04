//
//  HYPRJSContextSource.h
//  HyprMX-Framework
//
//  Created by Sean Reinhardt on 6/15/22.
//  Copyright © 2022 HyprMX Mobile LLC. All rights reserved.
//

#ifndef HYPRJSContextSource_h
#define HYPRJSContextSource_h
#import <Foundation/Foundation.h>
#import <JavascriptCore/JavascriptCore.h>
@class HYPRJSContext, HYPRPresentationController, HYPRImageCache;
@protocol HYPRJSContextSource <NSObject>
@property (strong, atomic, readonly) HYPRJSContext *context;
@property (nonatomic, strong) HYPRPresentationController *presentationController API_AVAILABLE(ios(13.4));
- (HYPRImageCache *)imageCache API_AVAILABLE(ios(13.4));
@end
#endif /* HYPRJSContextSource_h */
