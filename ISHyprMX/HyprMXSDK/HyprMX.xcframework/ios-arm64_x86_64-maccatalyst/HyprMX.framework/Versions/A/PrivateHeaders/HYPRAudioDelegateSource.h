//
//  HYPRAudioDelegateSource.h
//  HyprMX-Framework
//
//  Created by Sean Reinhardt on 4/3/23.
//  Copyright © 2023 HyprMX Mobile LLC. All rights reserved.
//

#ifndef HYPRAudioDelegateSource_h
#define HYPRAudioDelegateSource_h

@protocol HYPRAudioDelegateSource <NSObject>

- (void)audioWillStart;
- (void)audioDidEnd;

@end
#endif /* HYPRAudioDelegateSource_h */
