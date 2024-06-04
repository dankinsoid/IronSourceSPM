//
//  HYPRTraitCollection.h
//  HyprMX
//
//  Created by Sean Reinhardt on 6/21/19.
//  Copyright © 2019 HyprMX Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
NS_CLASS_AVAILABLE_IOS(13.0)
@interface HYPRTraitCollection : UITraitCollection
+(NSDictionary <NSString*, id>*)traitDictionary;
+ (NSString *)deviceNameString;
@end

NS_ASSUME_NONNULL_END
