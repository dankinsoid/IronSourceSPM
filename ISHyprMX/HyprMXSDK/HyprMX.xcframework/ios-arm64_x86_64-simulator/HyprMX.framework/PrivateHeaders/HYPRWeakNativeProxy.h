//
//  HYPRWeakNativeProxy.h
//  HyprMX
//
//  Created by Sean Reinhardt on 6/3/22.
//  Copyright © 2022 HyprMX Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYPRWeakNativeProxy : NSObject
@property (weak, nonatomic) NSObject *delegate;
-(instancetype)initWithDelegate:(NSObject *)delegate;
@end

NS_ASSUME_NONNULL_END
