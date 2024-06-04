//
//  HYPRParameterControllerProtocol.h
//  HyprMX
//
//  Created by Sean Reinhardt on 9/12/22.
//  Copyright © 2022 HyprMX Mobile LLC. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <HyprMX/HYPRPreloadFetchStatusProtocol.h>
@class HYPRMediationProvider, HYPRJSContext, HYPROrientation, HYPRTransparencyTrackingManager;

API_AVAILABLE(ios(13.4))
@protocol HYPRParameterControllerProtocol <NSObject>
-(instancetype)initWithUserId:(NSString *)userId
                distributorId:(NSString *)distributorId
            mediationProvider:(HYPRMediationProvider *)mediationProvider
                 unityVersion:(NSString *)unityVersion
          isAgeRestrictedUser:(BOOL)isAgeRestrictedUser
               vastCacheQueue:(NSOperationQueue *)vastCacheQueue
                  orientation:(HYPROrientation *)orientation
                      context:(HYPRJSContext *)context
            preloadController:(id<HYPRPreloadFetchStatusProtocol>)preloadController
                         info:(NSDictionary<NSString *,id>*)info
              trackingManager:(HYPRTransparencyTrackingManager *)trackingManager;
- (void)addRequestManagerToContext:(void (^)(void))completion;
@end

@interface HYPRParameterController : NSObject <HYPRParameterControllerProtocol>
@end
