//
//  HYPRImageQueue.h
//  HyprMX-Framework
//
//  Created on 3/14/12.
//  Copyright (c) 2012 HyprMX Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <HyprMX/HYPRAvailability.h>

@class HYPRError, HYPRImage;

HYPR_CLASS_AVAILABLE_IOS
@interface HYPRImageCache : NSObject

/* image loader for downloading and caching images from a HYPRImage */
- (void)loadImage:(HYPRImage *)image
    withSession:(NSURLSession *)session
completionHandler:(void (^)(UIImage *downloadedImage))handler;

/* image loader for downloading and caching images */
- (void)loadImageAtURL:(NSString *)imageURL completionHandler:(void (^)(UIImage *image))handler;

/* image loader for downloading an image and cutting it out of the loaded resource */
- (void)loadImageAtURL:(NSString *)imageURL rect:(CGRect)rect completionHandler:(void (^)(UIImage *image))handler;

/* image loader for downloading an image and scaling it using a CG Context */
- (void)loadScaledImageAtURL:(NSString *)imageURL scale:(CGSize)newSize completionHandler:(void (^)(UIImage *image))handler;

@end
