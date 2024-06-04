//
//  HYPRPhotoActivityViewHelper.h
//  HyprMX
//
//  Created by Natalie Kim on 3/10/22.
//  Copyright © 2022 HyprMX Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <HyprMX/HYPRAvailability.h>
@class HYPRImageCache;
HYPR_CLASS_AVAILABLE_IOS
NS_ASSUME_NONNULL_BEGIN
extern NSString * const HYPRPhotoActivityHelperDomain;

@protocol HYPRPhotoActivityDelegate
-(void)readyToPresent:(UIActivityViewController *)activityView;
-(void)hyprPhotoDownloadSucceeded;
-(void)hyprPhotoDownloadFailedWithError:(nonnull NSError *)error;
-(void)imageStorageFailedWithError:(nonnull NSError *)error;
-(void)imageStorageSucceeded;
-(void)imageStorageCancelled;
@end

@class HYPRPhotoActivityViewHelper;
HYPR_CLASS_AVAILABLE_IOS
@interface HYPRPhotoActivityViewHelper : NSObject

-(void)beginDownload:(nullable NSString *)urlString;

- (instancetype)initWithCache:(HYPRImageCache *)imageCache
                       bundle:(NSBundle*)bundle
                     delegate:(id<HYPRPhotoActivityDelegate>)delegate;

@property (nonatomic, weak) id<HYPRPhotoActivityDelegate> delegate;
@property (nonatomic, weak) HYPRImageCache * imageCache;
NS_ASSUME_NONNULL_END
@end

