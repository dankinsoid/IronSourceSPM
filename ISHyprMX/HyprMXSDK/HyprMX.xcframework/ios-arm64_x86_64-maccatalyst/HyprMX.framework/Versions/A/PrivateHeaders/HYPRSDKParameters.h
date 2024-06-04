//
//  HYPRSDKParameters.h
//  HyprMX
//
//  Created by Sean Reinhardt on 12/7/19.
//  Copyright © 2019 HyprMX Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HYPRSDKParametersDelegate <NSObject>
+ (NSNumber *)msdkv;
+ (NSString *)sdkVersion;
+ (NSString *)initializationHostName;
@end

@interface HYPRSDKParameters : NSObject <HYPRSDKParametersDelegate>
@end

NS_ASSUME_NONNULL_END
