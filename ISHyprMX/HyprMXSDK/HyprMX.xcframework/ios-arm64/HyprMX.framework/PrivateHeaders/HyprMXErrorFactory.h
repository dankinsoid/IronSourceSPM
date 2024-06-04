//
//  HyprMXErrorFactory.h
//  HyprMX-Framework
//
//  Created by Sean Reinhardt on 6/1/21.
//  Copyright © 2021 HyprMX Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HyprMX/HyprMXPlacement.h>
NS_ASSUME_NONNULL_BEGIN

@interface HyprMXErrorFactory : NSObject
+(NSError *)errorWithHyprMXError:(HyprMXError)code;
+(NSError *)errorWithHyprMXError:(HyprMXError)code message:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
