//
//  HYPRSetTimeout.h
//  HyprMX-SDK
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class HYPRJSContext;

@protocol HYPRNativeTimerProtocol <JSExport>
- (void)startNativeTimer:(nullable NSString *)identifier :(nullable NSNumber *)milliseconds :(nullable NSString *)callback;
- (void)stopTimer:(nullable NSString *)identifier;
- (void)updateTimer:(nullable NSString *)identifier :(nullable NSNumber *)milliseconds;
- (nullable instancetype)initWithContext:(nullable HYPRJSContext *)context;
@end

@interface HYPRNativeTimer : NSObject <HYPRNativeTimerProtocol>
@end
