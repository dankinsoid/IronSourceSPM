//  HYPRLogger.h
//  HyprMX
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <HyprMX/HyprMX.h>
/* Logs message at the HYPRLogLevelError level
 *
 * @param format A format string. This value must not be nil. Raises an NSInvalidArgumentException if format is nil.
 * @param ... A comma-separated list of arguments to substitute into format.
 */
extern void HYPRLogE(NSString* format, ...);

/* Logs message at the HYPRLogLevelVerbose level
 *
 * @param format A format string. This value must not be nil. Raises an NSInvalidArgumentException if format is nil.
 * @param ... A comma-separated list of arguments to substitute into format.
 */
extern void HYPRLogV(NSString* format, ...);

/* Logs message at the HYPRLogLevelDebug level
 *
 * @param format A format string. This value must not be nil. Raises an NSInvalidArgumentException if format is nil.
 * @param ... A comma-separated list of arguments to substitute into format.
 */
extern void HYPRLogD(NSString* format, ...);

/* Overall Logger function, exposed for Swift since Swift cannot call a funcion with va_args
 *
 * @param level Log Level
 * @param format A format string. This value must not be nil. Raises an NSInvalidArgumentException if format is nil.
 */
extern void HYPRLog(HYPRLogLevel level, NSString *message);

/* Checks log level and stored enable all logs flag
 *
 * @param level The HYPRLogLevel value
 * @return YES if the level is enabled or flag is on, else NO
 */
extern BOOL HYPRShouldPostLog(HYPRLogLevel level);

/* Stores logged messages for reporting errors */
extern NSMutableString *HYPRLogMessages;
extern NSObject const *kHYPRLogMessagesLock;
extern void HYPRSetEnableAllLogs(BOOL);
