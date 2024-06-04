//
//  HYPRMediationProvider.h
//  HyprMX-Framework
//
//  Created by Sean Reinhardt on 6/8/21.
//  Copyright © 2021 HyprMX Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYPRMediationProvider : NSObject
-(instancetype)initWithMediationProvider:(nullable NSString*)mediator
                       mediatorSDKVersion:(nullable NSString*)sdkVersion
                           adapterVersion:(nullable NSString*)adapterVersion;
-(NSDictionary *)dictionaryValue;
@end

NS_ASSUME_NONNULL_END
