//
//  HYPRTransparencyTrackingController.h
//  HYPRPermissions
//
//  Created by Sean Reinhardt on 7/23/20.
//  Copyright © 2020 HyprMX Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <HyprMX/HYPRAvailability.h>
NS_ASSUME_NONNULL_BEGIN

@protocol HYPRTransparencyTrackingManager <JSExport>
- (NSString *)getTrackingPermissionStatus;
- (void)promptForTrackingPermissionWithCallback:(NSString *)callback;
@end

HYPR_CLASS_AVAILABLE_IOS
@interface HYPRTransparencyTrackingManager : NSObject <HYPRTransparencyTrackingManager>
+(nullable instancetype)addTrackerToContext:(JSContext *)context bundle:(NSBundle *)bundle;
@end

NS_ASSUME_NONNULL_END
