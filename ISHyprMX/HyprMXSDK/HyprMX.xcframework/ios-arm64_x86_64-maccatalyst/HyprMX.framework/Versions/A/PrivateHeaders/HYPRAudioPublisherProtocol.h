//
//  HYPRAudioPublisherProtocol.h
//  HyprMX
//
//  Created by Sean Reinhardt on 9/12/22.
//  Copyright © 2022 HyprMX Mobile LLC. All rights reserved.
//
#import <Foundation/Foundation.h>
@import AVKit;

@class HYPRJSContext;

API_AVAILABLE(ios(13.4))
@protocol HYPRAudioPublisherProtocol <NSObject>
-(instancetype _Nullable )initWithSubscriber:(nullable HYPRJSContext *)subscriber
                                audioSession:(nullable AVAudioSession *)audioSesion;
@end

@interface HYPRAudioEventPublisher : NSObject <HYPRAudioPublisherProtocol>
@end
