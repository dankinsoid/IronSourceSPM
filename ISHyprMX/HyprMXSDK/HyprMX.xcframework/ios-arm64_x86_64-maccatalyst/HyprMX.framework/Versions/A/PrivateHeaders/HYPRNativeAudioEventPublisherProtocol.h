//
//  HYPRAudioPublisherProtocol.h
//  HyprMX
//
//  Created by Sean Reinhardt on 9/12/22.
//  Copyright © 2022 HyprMX Mobile LLC. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <HyprMX/HYPRAudioDelegateSource.h>

API_AVAILABLE(ios(13.4))
@protocol HYPRNativeAudioEventPublisherProtocol
- (nullable instancetype)initWithContext:(nonnull HYPRJSContext *)context audioDelegateSource:(nonnull NSObject<HYPRAudioDelegateSource>*)delegate;
@end

@interface HYPRNativeAudioEventPublisher : NSObject <HYPRNativeAudioEventPublisherProtocol>
@end
