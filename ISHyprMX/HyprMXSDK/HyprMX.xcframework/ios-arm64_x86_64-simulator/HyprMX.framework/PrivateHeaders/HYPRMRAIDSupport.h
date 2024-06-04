//
//  HYPRMRAIDSupport.h
//  HyprMX-Framework
//
//  Created by Kevin E. Rafferty II on 1/18/17.
//  Copyright © 2017 HyprMX Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <HyprMX/HYPRAvailability.h>
HYPR_CLASS_AVAILABLE_IOS

@protocol HYPRMRAIDEventReceiver <NSObject>

- (void)mraidPlayVideo:(NSString*)payload;
- (void)mraidStorePicture:(NSString*)payload;
- (void)mraidUseCustomClose:(BOOL)isClosable;
- (void)mraidSetOrientationProperties:(BOOL)allowOrientationChange
                     forceOrientation:(NSString *)forceOrientationChange;

@end

HYPR_CLASS_AVAILABLE_IOS
@interface HYPRMRAIDSupport : NSObject

+ (NSDictionary *)deviceDataForScreen:(UIScreen *)screen;
+ (NSDictionary *)sizeInfoForBounds:(CGRect)bounds;
+ (NSDictionary *)screenSizeInfoForScreen:(UIScreen *)screen;
+ (NSString *)supportsString;

+ (void)determineOrientationProperties:(BOOL)isRotationAllowed
                      forceOrientation:(NSString *)foredOrientation
                 currentRotationStatus:(BOOL)currentRotation
                            completion:(void (^)(UIInterfaceOrientation newInterfaceOrientation,
                                                 UIInterfaceOrientation mraidInterfaceOrientation,
                                                 BOOL isRotationAllowed,
                                                 NSError *error))completion;
@end
