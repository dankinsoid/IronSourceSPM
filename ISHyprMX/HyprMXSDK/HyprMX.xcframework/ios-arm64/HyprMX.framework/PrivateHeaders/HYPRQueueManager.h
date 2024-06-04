//
//  HYPRQueueManager.h
//  HyprMX-Framework
//
//  Created by Sean Reinhardt on 11/13/15.
//  Copyright © 2015 HyprMX Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HYPRBlock)(void);

@interface HYPRQueueManager : NSObject


/*
 * Runs a block of code Asynchronously on a requested Queue.
 * @param queue     The requested queue on which to excute the code block
 * @param block     Block to be submitted for execution
 */
+ (void)addOperationToQueue:(NSOperationQueue *)queue block:(HYPRBlock)block;

/*
 * Runs a block of code Synchronously on a requested Queue.
 * @param queue     The requested queue on which to excute the code block
 * @param block     Block to be submitted for execution
 */
+ (void)addSynchronousOperationToQueue:(NSOperationQueue *)queue block:(HYPRBlock)block;

/*
 * Runs a block of code Asynchronously on the main Queue.
 * @param block     Block to be submitted for execution
 */
+ (void)addOperationToMainQueue:(HYPRBlock)block;

/*
 * Runs a block of code Asynchronously on the main Queue.
 * @param block     Block to be submitted for execution
 */
+ (void)addSynchronousOperationToMainQueue:(HYPRBlock)block;

/*
 * Getter for mainQueue.
 */
+(NSOperationQueue *)main;

@end

#pragma mark -
#pragma mark Threading Macros
#pragma mark -

// Main Queue Macros

#define HYPR_ASSERT_MAIN_QUEUE HYPRAssertInDebugger(_cmd, __FILE__, __LINE__, [[NSOperationQueue mainQueue] isEqual:[NSOperationQueue currentQueue]], [NSString stringWithFormat:@"current queue (%@) is not main queue", [[NSOperationQueue currentQueue] name]])

#define HYPR_IMPLEMENT_SETTER_FOR_PROPERTY_ON_MAIN_QUEUE(propertyType, propertyName, setterName) \
- (void)setterName:(propertyType)propertyName { \
HYPR_ASSERT_MAIN_QUEUE;  \
_##propertyName = propertyName; \
}

#define HYPR_IMPLEMENT_IVAR_AND_GETTER_ON_MAIN_QUEUE(propertyType, propertyName) \
@synthesize propertyName = _##propertyName; \
- (propertyType)propertyName { \
HYPR_ASSERT_MAIN_QUEUE;  \
return _##propertyName; \
}

#define HYPR_IMPLEMENT_BOOL_IVAR_AND_GETTER_ON_MAIN_QUEUE(propertyName, getterName) \
@synthesize propertyName = _##propertyName; \
- (BOOL)getterName { \
HYPR_ASSERT_MAIN_QUEUE;  \
return _##propertyName; \
}

#define HYPR_IMPLEMENT_PROPERTY_COPY_ON_MAIN_QUEUE(propertyType, propertyName, setterName) \
HYPR_IMPLEMENT_IVAR_AND_GETTER_ON_MAIN_QUEUE(propertyType, propertyName) \
- (void)setterName:(propertyType)propertyName { \
HYPR_ASSERT_MAIN_QUEUE;  \
_##propertyName = [propertyName copy]; \
}

#define HYPR_IMPLEMENT_PROPERTY_ON_MAIN_QUEUE(propertyType, propertyName, setterName) \
HYPR_IMPLEMENT_IVAR_AND_GETTER_ON_MAIN_QUEUE(propertyType, propertyName) \
HYPR_IMPLEMENT_SETTER_FOR_PROPERTY_ON_MAIN_QUEUE(propertyType, propertyName, setterName)

#define HYPR_IMPLEMENT_BOOL_PROPERTY_ON_MAIN_QUEUE(propertyName, getterName, setterName) \
HYPR_IMPLEMENT_BOOL_IVAR_AND_GETTER_ON_MAIN_QUEUE(propertyName, getterName) \
HYPR_IMPLEMENT_SETTER_FOR_PROPERTY_ON_MAIN_QUEUE(BOOL, propertyName, setterName)

#define HYPR_IMPLEMENT_PROPERTY_SYNCHRONIZED(propertyType, propertyName, setterName) \
@synthesize propertyName = _##propertyName; \
- (propertyType)propertyName { \
@synchronized(self) { \
return _##propertyName; \
} \
} \
- (void)setterName:(propertyType)propertyName { \
@synchronized(self) { \
_##propertyName = propertyName; \
} \
}

#define HYPR_ASSERT_ON_PARSER_QUEUE HYPRAssertInDebugger(_cmd, __FILE__, __LINE__, [[NSOperationQueue currentQueue] isEqual:HyprMX.vastParsingOperationQueue], [NSString stringWithFormat:@"current queue (%@) is not the VAST parser's operation queue", [[NSOperationQueue currentQueue] name]])

#define HYPR_IMPLEMENT_PROPERTY_ON_PARSER_QUEUE(propertyType, propertyName, setterName) \
@synthesize propertyName = _##propertyName; \
- (void)setterName:(propertyType)propertyName { \
HYPR_ASSERT_ON_PARSER_QUEUE;  \
_##propertyName = propertyName; \
}\
\
- (propertyType)propertyName { \
HYPR_ASSERT_ON_PARSER_QUEUE;  \
return _##propertyName; \
}

// Settings Queue Macros

#define HYPR_ASSERT_JS_LOADING_QUEUE HYPRAssertInDebugger(_cmd, __FILE__, __LINE__, [HyprMX.jsLoadingOperationQueue isEqual:[NSOperationQueue currentQueue]], [NSString stringWithFormat:@"current queue (%@) is not the settings operation queue", [[NSOperationQueue currentQueue] name]])


